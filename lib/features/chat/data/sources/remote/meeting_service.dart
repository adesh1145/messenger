import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:messenger/core/constants/firebase_constant.dart';
import 'package:messenger/core/utils/enums.dart';
import 'package:messenger/features/chat/data/models/call_model.dart';
import 'package:messenger/features/chat/data/models/ice_candidate_model.dart';
import 'package:messenger/features/chat/data/models/participant.dart';
import 'package:messenger/features/chat/data/models/session_description.dart';

class CallDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> makeCall(String roomId, Participant me) async {
    final roomRef = _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId);

    await roomRef.set(
      CallModel(
        roomId: roomId,
        isGroupCall: false,
        createdAt: DateTime.now(),
        callType: CallType.video,
        callStatus: CallState.calling,
        participants: [me],
      ).toMap(),
    );
  }

  Stream<List<CallModel>> listenRoomsCallStatus() {
    return _firestore
        .collection(FirebaseConstant.roomsCollection)
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((doc) => CallModel.fromMap(doc.data())).toList(),
        );
  }

  Future<void> acceptCall(String roomId, Participant me) async {
    final roomRef = _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId);
    await roomRef.update({
      'callStatus': CallState.connecting.value,
      'participants': FieldValue.arrayUnion([me.toMap()]),
    });
  }

  Future<void> changeCallStatus(String roomId, CallState status) async {
    final roomRef = _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId);
    await roomRef.update({'callStatus': status.value});
  }

  Stream<CallModel> listenParticipants(String roomId) {
    return _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId)
        .snapshots()
        .map((snap) {
          final data = snap.data();

          return CallModel.fromMap(data!);
        });
  }

  Future<void> addOffer(String roomId, SessionDescription offer) async {
    await _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId)
        .collection('offers')
        .doc('${offer.from}_${offer.to}')
        .set(offer.toMap());
  }

  Future<void> addAnswer(String roomId, SessionDescription answer) async {
    await _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId)
        .collection('answers')
        .doc('${answer.from}_${answer.to}')
        .set(answer.toMap());
  }

  Future<void> addCandidate(String roomId, IceCandidateModel candidate) async {
    await _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId)
        .collection('candidates')
        .add(candidate.toMap());
  }

  Stream<List<SessionDescription>> listenOffers(String roomId) {
    return _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId)
        .collection('offers')
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => SessionDescription.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<SessionDescription>> listenAnswers(String roomId) {
    return _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId)
        .collection('answers')
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => SessionDescription.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<IceCandidateModel>> listenCandidates(String roomId) {
    return _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId)
        .collection('candidates')
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => IceCandidateModel.fromMap(doc.data()))
              .toList(),
        );
  }

  /// If no active participants remain, delete entire room.
  Future<void> maybeDeleteRoom(String roomId) async {
    final roomRef = _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId);

    final snap = await roomRef.get();
    if (!snap.exists) return;

    // Subcollections to delete
    final subcollections = ['offers', 'answers', 'candidates'];

    for (var sub in subcollections) {
      final querySnapshot = await roomRef.collection(sub).get();
      WriteBatch batch = _firestore.batch();

      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      // Commit batch if there are docs
      if (querySnapshot.docs.isNotEmpty) {
        await batch.commit();
      }
    }

    // Finally delete the room document itself
    await roomRef.delete();
  }

  // Updated portions of MeetingService
  Future<void> removeUserArtifacts(String roomId, String uid) async {
    final roomRef = _firestore
        .collection(FirebaseConstant.roomsCollection)
        .doc(roomId);

    try {
      // Use batch for better performance
      WriteBatch batch = _firestore.batch();

      // Remove candidates
      final candidates = await roomRef.collection('candidates').get();
      for (var doc in candidates.docs) {
        final data = doc.data();
        if (data['from'] == uid || data['to'] == uid) {
          batch.delete(doc.reference);
        }
      }

      // Remove offers
      final offers = await roomRef.collection('offers').get();
      for (var doc in offers.docs) {
        final data = doc.data();
        if (data['from'] == uid || data['to'] == uid) {
          batch.delete(doc.reference);
        }
      }

      // Remove answers
      final answers = await roomRef.collection('answers').get();
      for (var doc in answers.docs) {
        final data = doc.data();
        if (data['from'] == uid || data['to'] == uid) {
          batch.delete(doc.reference);
        }
      }

      await batch.commit();
    } catch (e) {
      log('Error removing user artifacts: $e');
    }
  }
}
