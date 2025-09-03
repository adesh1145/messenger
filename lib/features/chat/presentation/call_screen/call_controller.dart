import 'dart:async';
import 'dart:developer';

import 'package:flutter_webrtc/flutter_webrtc.dart' as WebRTC;
import 'package:get/get.dart';
import 'package:messenger/features/chat/domain/repository/call_repository.dart';

import '../../../../core/utils/enums.dart';
import '../../data/models/ice_candidate_model.dart';
import '../../data/models/participant.dart';
import '../../data/models/session_description.dart';

class CallController extends GetxController {
  final CallRepository callRepository;
  CallController(this.callRepository);
  final data = Get.arguments;
  RxBool isLoading = false.obs;
  RxBool isLocalStreamReady = false.obs;
  RxBool isMicOn = true.obs;
  RxBool isCamOn = true.obs;
  Rx<CallState> callState = CallState.calling.obs;
  RxList<Participant> participants = <Participant>[].obs;
  RxMap<String, WebRTC.RTCVideoRenderer> remoteRenderers =
      <String, WebRTC.RTCVideoRenderer>{}.obs;

  final WebRTC.RTCVideoRenderer localRenderer = WebRTC.RTCVideoRenderer();
  Rx<WebRTC.MediaStream?> localStreamRx = Rx<WebRTC.MediaStream?>(null);

  String? myUid;
  String? roomId;

  Map<String, WebRTC.RTCPeerConnection> peerConnections = {};
  Map<String, String> peerConnectionStates = {};
  Set<String> pendingConnections = {};

  WebRTC.MediaStream? get localStream => localStreamRx.value;

  set localStream(WebRTC.MediaStream? stream) {
    localStreamRx.value = stream;
    isLocalStreamReady.value = stream != null;
  }

  bool _started = false;
  final Set<String> _processedOffers = {};
  final Set<String> _processedAnswers = {};
  final Set<String> _pendingOffers = {};

  StreamSubscription? _offersSub;
  StreamSubscription? _answersSub;
  StreamSubscription? _candidatesSub;
  StreamSubscription? _participantsSub;
  StreamSubscription? _callStatusSub;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeController();
  }

  Future<void> _initializeController() async {
    if (_started) {
      await _cleanupForHotReload();
    }
    _started = true;

    isLoading.value = true;

    try {
      await localRenderer.initialize();

      myUid = data['uid'] as String?;
      roomId = data['roomId'] as String?;

      log('=== Initializing controller for user: $myUid in room: $roomId ===');

      final me = Participant(
        uid: myUid!,
        name: data['name'] ?? 'Unknown',
        joinedAt: DateTime.now(),
      );

      if (data['isCreator'] == true) {
        await createRoom(roomId!, me);
      } else {
        await joinRoom(roomId!, me);
      }

      await _getUserMedia();
      listenToRoom();
    } catch (e) {
      log('Error initializing controller: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _cleanupForHotReload() async {
    try {
      _cancelSubscriptions();

      for (final pc in peerConnections.values) {
        await pc.close();
      }
      peerConnections.clear();
      peerConnectionStates.clear();
      pendingConnections.clear();

      for (final renderer in remoteRenderers.values) {
        await renderer.dispose();
      }
      remoteRenderers.clear();

      _processedOffers.clear();
      _processedAnswers.clear();
      _pendingOffers.clear();
    } catch (e) {
      log('Error during hot reload cleanup: $e');
    }
  }

  @override
  void onClose() {
    leaveCall();
    super.onClose();
  }

  Future<void> createRoom(String id, Participant me) async {
    roomId = id;
    myUid = me.uid;
    await callRepository.refreshRoom(roomId!);
    await callRepository.makeCall(roomId!, me);
    log('Room created: $id by $myUid');
  }

  Future<void> joinRoom(String id, Participant me) async {
    roomId = id;
    myUid = me.uid;
    await callRepository.acceptCall(id, me);
    log('Joined room: $id as $myUid');
  }

  Future<void> _getUserMedia() async {
    try {
      if (localStream != null) {
        localStream!.getTracks().forEach((track) => track.stop());
      }

      final mediaConstraints = {
        'audio': true,
        'video': {
          'facingMode': 'user',
          'width': {'ideal': 1280},
          'height': {'ideal': 720},
        },
      };

      final stream = await WebRTC.navigator.mediaDevices.getUserMedia(
        mediaConstraints,
      );

      localStream = stream;
      localRenderer.srcObject = stream;

      _updateTrackStates();
      log('Local media stream initialized successfully');
    } catch (e, st) {
      log('Error getting user media: $e\n$st');
      isLocalStreamReady.value = false;
    }
  }

  void _updateTrackStates() {
    if (localStream != null) {
      final audioTracks = localStream!.getAudioTracks();
      final videoTracks = localStream!.getVideoTracks();

      isMicOn.value = audioTracks.isNotEmpty
          ? audioTracks.first.enabled
          : false;
      isCamOn.value = videoTracks.isNotEmpty
          ? videoTracks.first.enabled
          : false;
    }
  }

  Future<WebRTC.RTCPeerConnection> _createPeerConnection(String peerId) async {
    log('Creating peer connection for: $peerId');

    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        {'urls': 'stun:stun1.l.google.com:19302'},
      ],
      'sdpSemantics': 'unified-plan',
    };

    final peerConnection = await WebRTC.createPeerConnection(configuration);

    // Add local tracks
    if (localStream != null) {
      for (final track in localStream!.getTracks()) {
        await peerConnection.addTrack(track, localStream!);
      }
      log('Added local tracks to peer connection for $peerId');
    }

    peerConnection.onTrack = (WebRTC.RTCTrackEvent event) async {
      log('onTrack event for $peerId - streams: ${event.streams.length}');
      if (event.streams.isNotEmpty) {
        final stream = event.streams[0];
        await _handleRemoteStream(peerId, stream);
      }
    };

    // Handle ICE candidates
    peerConnection.onIceCandidate = (WebRTC.RTCIceCandidate candidate) {
      if (candidate.candidate != null && roomId != null) {
        log('Sending ICE candidate for $peerId');
        callRepository.addCandidate(
          roomId!,
          IceCandidateModel(
            from: myUid!,
            to: peerId,
            candidate: candidate.candidate!,
            sdpMid: candidate.sdpMid ?? "",
            sdpMLineIndex: candidate.sdpMLineIndex ?? 0,
          ),
        );
      }
    };

    // Enhanced connection state tracking
    peerConnection.onIceConnectionState = (state) {
      log('ICE Connection State with $peerId: $state');
      peerConnectionStates[peerId] = state.toString();

      if (state ==
          WebRTC.RTCIceConnectionState.RTCIceConnectionStateConnected) {
        log('Peer $peerId connected successfully');
        pendingConnections.remove(peerId);
        callRepository.updateCallStatus(roomId!, CallState.connected);
      } else if (state ==
              WebRTC.RTCIceConnectionState.RTCIceConnectionStateDisconnected ||
          state == WebRTC.RTCIceConnectionState.RTCIceConnectionStateFailed) {
        log('Peer $peerId disconnected or failed');
        _handlePeerDisconnection(peerId);
        callRepository.updateCallStatus(roomId!, CallState.failed);
      }
    };

    peerConnection.onSignalingState = (state) {
      log('Signaling State with $peerId: $state');
    };

    return peerConnection;
  }

  Future<void> _handleRemoteStream(
    String peerId,
    WebRTC.MediaStream stream,
  ) async {
    if (!remoteRenderers.containsKey(peerId)) {
      final renderer = WebRTC.RTCVideoRenderer();
      await renderer.initialize();
      renderer.srcObject = stream;
      remoteRenderers[peerId] = renderer;
      log('✅ Added remote renderer for $peerId');
    } else {
      // Update existing renderer
      remoteRenderers[peerId]!.srcObject = stream;
      log('🔄 Updated existing renderer for $peerId');
    }
  }

  Future<void> _createOfferFor(String peerId) async {
    if (pendingConnections.contains(peerId) ||
        peerConnections.containsKey(peerId)) {
      log(
        '⚠️ Connection already exists or pending for $peerId, skipping offer',
      );
      return;
    }

    log('📤 Creating offer for: $peerId');
    pendingConnections.add(peerId);

    try {
      final pc = await _createPeerConnection(peerId);
      peerConnections[peerId] = pc;

      final offer = await pc.createOffer();
      await pc.setLocalDescription(offer);

      // Mark as pending
      _pendingOffers.add(peerId);

      await callRepository.addOffer(
        roomId!,
        SessionDescription(
          from: myUid!,
          to: peerId,
          type: SdpType.offer,
          sdp: offer.sdp ?? "",
        ),
      );

      log('✅ Offer created and sent for $peerId');
    } catch (e) {
      log('❌ Error creating offer for $peerId: $e');
      pendingConnections.remove(peerId);
      peerConnections.remove(peerId);
      _pendingOffers.remove(peerId);
    }
  }

  Future<void> _handleOffer(SessionDescription offer) async {
    final key = '${offer.from}_${offer.to}';
    if (_processedOffers.contains(key)) {
      log('Offer already processed from ${offer.from}, skipping...');
      return;
    }

    if (_pendingOffers.contains(offer.from)) {
      log('Race condition detected with ${offer.from}');
      if (myUid!.compareTo(offer.from) > 0) {
        log('We win the race, ignoring incoming offer from ${offer.from}');
        return;
      } else {
        log('They win the race, processing offer from ${offer.from}');
        // Clean up our pending offer
        _pendingOffers.remove(offer.from);
        // Close existing connection if any
        final existingPc = peerConnections[offer.from];
        if (existingPc != null) {
          await existingPc.close();
          peerConnections.remove(offer.from);
        }
      }
    }

    _processedOffers.add(key);
    log('Handling offer from: ${offer.from}');

    try {
      // Prevent duplicate connections
      if (peerConnections.containsKey(offer.from)) {
        log('Peer connection already exists for ${offer.from}');
        return;
      }

      pendingConnections.add(offer.from);
      final pc = await _createPeerConnection(offer.from);
      peerConnections[offer.from] = pc;

      await pc.setRemoteDescription(
        WebRTC.RTCSessionDescription(offer.sdp, "offer"),
      );
      log('Remote offer description set for ${offer.from}');

      final answer = await pc.createAnswer();
      await pc.setLocalDescription(answer);

      await callRepository.addAnswer(
        roomId!,
        SessionDescription(
          from: myUid!,
          to: offer.from,
          type: SdpType.answer,
          sdp: answer.sdp ?? "",
        ),
      );

      log('Answer created and sent for ${offer.from}');
    } catch (e) {
      log('Error handling offer from ${offer.from}: $e');
      _processedOffers.remove(key);
      pendingConnections.remove(offer.from);
      peerConnections.remove(offer.from);
    }
  }

  Future<void> _handleAnswer(SessionDescription answer) async {
    final key = '${answer.from}_${answer.to}';
    if (_processedAnswers.contains(key)) {
      log('Answer already processed from ${answer.from}, skipping...');
      return;
    }
    _processedAnswers.add(key);

    log('Handling answer from: ${answer.from}');

    try {
      final pc = peerConnections[answer.from];
      if (pc == null) {
        log('No peer connection found for ${answer.from}');
        return;
      }

      final currentState = pc.signalingState;
      log('Current signaling state for ${answer.from}: $currentState');

      if (currentState ==
          WebRTC.RTCSignalingState.RTCSignalingStateHaveLocalOffer) {
        await pc.setRemoteDescription(
          WebRTC.RTCSessionDescription(answer.sdp, "answer"),
        );
        log('Remote answer description set for ${answer.from}');
        _pendingOffers.remove(answer.from);
      } else {
        log('Invalid state for setting remote answer: $currentState');
        _processedAnswers.remove(key);
      }
    } catch (e) {
      log('Error handling answer from ${answer.from}: $e');
      _processedAnswers.remove(key);
    }
  }

  void _handlePeerDisconnection(String peerId) {
    log('Handling disconnection for: $peerId');

    final renderer = remoteRenderers.remove(peerId);
    renderer?.dispose();

    peerConnections[peerId]?.close();
    peerConnections.remove(peerId);
    peerConnectionStates.remove(peerId);
    pendingConnections.remove(peerId);

    // Clean up processed offers/answers
    _processedOffers.removeWhere((key) => key.contains(peerId));
    _processedAnswers.removeWhere((key) => key.contains(peerId));
    _pendingOffers.remove(peerId);
  }

  void listenToRoom() {
    if (roomId == null) return;

    log('Starting to listen to room: $roomId');
    _cancelSubscriptions();

    // Listen to participants
    _participantsSub = callRepository.listenCall(roomId!).listen((calls) async {
      if (calls.callStatus == CallState.ended ||
          calls.callStatus == CallState.failed) {
        leaveCall();
      }
      callState.value = calls.callStatus;

      final list = calls.participants;
      log('Participants updated: ${list.map((p) => p.uid).toList()}');
      participants.value = list;
      final otherParticipants = list.where((p) => p.uid != myUid).toList();
      for (final participant in otherParticipants) {
        if (!peerConnections.containsKey(participant.uid) &&
            !pendingConnections.contains(participant.uid)) {
          final shouldInitiate = _shouldInitiateConnection(participant.uid);
          if (shouldInitiate) {
            log('Initiating connection to: ${participant.uid}');
            await Future.delayed(Duration(milliseconds: 50));
            await _createOfferFor(participant.uid);
          } else {
            log('Waiting for offer from: ${participant.uid}');
          }
        }
      }

      // Clean up disconnected participants
      final currentParticipantIds = otherParticipants.map((p) => p.uid).toSet();
      final toRemove = peerConnections.keys
          .where((peerId) => !currentParticipantIds.contains(peerId))
          .toList();

      for (final peerId in toRemove) {
        _handlePeerDisconnection(peerId);
      }
    });

    // Listen to offers
    _offersSub = callRepository.listenOffers(roomId!).listen((offers) {
      for (var offer in offers) {
        if (offer.to == myUid && offer.from != myUid) {
          log('Received offer from: ${offer.from}');
          _handleOffer(offer);
        }
      }
    });

    // Listen to answers
    _answersSub = callRepository.listenAnswers(roomId!).listen((answers) {
      for (var answer in answers) {
        if (answer.to == myUid && answer.from != myUid) {
          log('Received answer from: ${answer.from}');
          _handleAnswer(answer);
        }
      }
    });

    // Listen to candidates
    _candidatesSub = callRepository.listenCandidates(roomId!).listen((
      candidates,
    ) {
      for (var candidate in candidates) {
        if (candidate.to == myUid && candidate.from != myUid) {
          _addIceCandidate(candidate);
        }
      }
    });
  }

  bool _shouldInitiateConnection(String peerId) {
    return myUid!.compareTo(peerId) > 0;
  }

  void _addIceCandidate(IceCandidateModel candidateModel) {
    final pc = peerConnections[candidateModel.from];
    if (pc != null) {
      final candidate = WebRTC.RTCIceCandidate(
        candidateModel.candidate,
        candidateModel.sdpMid,
        candidateModel.sdpMLineIndex,
      );
      pc.addCandidate(candidate).catchError((e) {
        log('Error adding candidate from ${candidateModel.from}: $e');
      });
    }
  }

  void _cancelSubscriptions() {
    _offersSub?.cancel();
    _answersSub?.cancel();
    _candidatesSub?.cancel();
    _participantsSub?.cancel();
    _callStatusSub?.cancel();

    _offersSub = null;
    _answersSub = null;
    _candidatesSub = null;
    _participantsSub = null;
    _callStatusSub = null;
  }

  void toggleMic() {
    final audioTrack = localStream?.getAudioTracks().firstOrNull;
    if (audioTrack != null) {
      audioTrack.enabled = !audioTrack.enabled;
      isMicOn.value = audioTrack.enabled;
      log('Mic toggled: ${audioTrack.enabled}');
    }
  }

  void toggleCamera() {
    final videoTrack = localStream?.getVideoTracks().firstOrNull;
    if (videoTrack != null) {
      videoTrack.enabled = !videoTrack.enabled;
      isCamOn.value = videoTrack.enabled;
      log('Camera toggled: ${videoTrack.enabled}');
    }
  }

  void switchCamera() {
    final videoTrack = localStream?.getVideoTracks().firstOrNull;
    if (videoTrack != null) {
      try {
        WebRTC.Helper.switchCamera(videoTrack);
        log('Camera switched');
      } catch (e) {
        log('switchCamera error: $e');
      }
    }
  }

  Future<void> leaveCall() async {
    try {
      log('Leaving call...');

      _cancelSubscriptions();

      if (localStream != null) {
        localStream!.getTracks().forEach((track) => track.stop());
        localStream = null;
        localRenderer.srcObject = null;
      }

      for (final pc in peerConnections.values) {
        await pc.close();
      }
      peerConnections.clear();
      peerConnectionStates.clear();
      pendingConnections.clear();

      for (final renderer in remoteRenderers.values) {
        await renderer.dispose();
      }
      remoteRenderers.clear();

      if (roomId != null && myUid != null) {
        await callRepository.updateCallStatus(roomId!, CallState.ended);
      }

      await localRenderer.dispose();

      isLocalStreamReady.value = false;
      isMicOn.value = true;
      isCamOn.value = true;
      participants.clear();
      Get.back();
      log('Call ended successfully');
    } catch (e) {
      log('Error during cleanup: $e');
    }
  }
}
