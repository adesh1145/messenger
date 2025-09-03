import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:messenger/core/config/app_routes.dart';
import 'package:messenger/core/utils/enums.dart';
import 'package:messenger/features/chat/data/models/call_model.dart';
import 'package:messenger/features/chat/domain/usecase/create_new_chat.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';
import 'package:messenger/features/chat/domain/usecase/seach_user_usecase.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../profile/presentation/profile_controller.dart';
import '../../domain/entities/chats_entity.dart';
import '../../domain/repository/call_repository.dart';
import '../../domain/usecase/get_chats.dart';
import '../../domain/usecase/get_user.dart';

class ChatListController extends GetxController {
  final SeachUserUsecase searchUserUseCase;
  final CreateNewChatusecase createNewChat;
  final GetChats getChats;
  final GetUserUsecase getUserUsecase;
  final CallRepository callRepository;
  ChatListController(
    this.searchUserUseCase,
    this.createNewChat,
    this.getChats,
    this.getUserUsecase,
    this.callRepository,
  );
  RxBool searchBarStatus = false.obs;
  final searchTextController = TextEditingController();
  RxList<User> searchedUsers = <User>[].obs;
  RxMap<String, User> chatsUsers = <String, User>{}.obs;

  RxBool searchLoading = false.obs;
  RxBool createChatLoading = false.obs;
  RxBool chatsListLoading = false.obs;
  StreamSubscription<List<CallModel>>? callSubscription;

  @override
  void onInit() {
    super.onInit();
    callSubscription = callRepository.listenAllCallStream().listen((calls) {
      for (var call in calls) {
        bool isExist = false;
        for (var participant in call.participants) {
          if (participant.uid == Get.find<ProfileController>().user.value.uid) {
            isExist = true;
          }
        }
        if (!isExist) {
          callRepository.updateCallStatus(call.roomId, CallState.ringing);
        }
        if (call.callStatus == CallState.ringing &&
            DateTime.now().isBefore(
              call.createdAt.add(const Duration(seconds: 30)),
            )) {
          showIncomingCall(call.participants[0].name, call.roomId);
        }
      }
    });
    listenToCallEvents();
  }

  @override
  void onClose() {
    super.onClose();
    callSubscription?.cancel();
  }

  Future<void> getChatList() async {}
  Future<void> searchChat(String query) async {
    searchLoading.value = true;
    final result = await searchUserUseCase(query);
    result.fold((l) => customSnackBar(l.message, type: SnackBarType.error), (
      r,
    ) {
      searchedUsers.value = r;
    });
    searchLoading.value = false;
  }

  Future<void> createChat(String userId) async {
    createChatLoading.value = true;
    final result = await createNewChat(userId);
    result.fold((l) => customSnackBar(l.message, type: SnackBarType.error), (
      r,
    ) {
      searchBarStatus.value = false;
      searchTextController.clear();
      Get.toNamed(
        AppRoutes.chatScreen,
        parameters: {"chatId": r.id},
        arguments: {
          "oppenantId": r.participants.firstWhere(
            (user) => user != Get.find<ProfileController>().user.value.uid,
          ),
        },
      );
    });
    createChatLoading.value = false;
  }

  Stream<List<ChatsEntity>> getChatsList() {
    return getChats.call();
  }

  Future<void> getUserDetail(String uuid) async {
    final result = await getUserUsecase(uuid);
    result.fold((l) => customSnackBar(l.message, type: SnackBarType.error), (
      r,
    ) {
      chatsUsers[uuid] = r;
    });
  }

  Future<void> triggerIncomingCall(String chatId) async {
    await showIncomingCall(
      Get.find<ProfileController>().user.value.name,
      chatId,
    );
  }

  Future<void> acceptCall(String chatId) async {
    // Camera/Mic permission check
    var cameraPermission = await Permission.camera.request();
    var microphonePermission = await Permission.microphone.request();

    if (cameraPermission.isGranted && microphonePermission.isGranted) {
      Get.toNamed(
        AppRoutes.callScreen,
        arguments: {
          'uid': Get.find<ProfileController>().user.value.uid,
          'name': Get.find<ProfileController>().user.value.name,
          'roomId': chatId,
        },
      );
    } else {
      customSnackBar(
        "Audio Video Call Permission not granted",
        type: SnackBarType.error,
      );
    }
  }

  Future<void> showIncomingCall(String callerName, String chatId) async {
    final params = <String, dynamic>{
      'id': const Uuid().v4(),
      'nameCaller': callerName,
      'appName': 'Messenger',
      'avatar': 'https://i.pravatar.cc/100', // optional image url
      'handle': 'Incoming Call',
      'type': 1, // 0 = audio, 1 = video
      'duration': 30000, // incoming screen timeout in ms
      'textAccept': 'Accept',
      'textDecline': 'Decline',
      'extra': <String, dynamic>{'chatId': chatId},
      'headers': <String, dynamic>{'apiKey': 'apiKey'},
      'android': <String, dynamic>{
        'isCustomNotification': true,
        'isShowLogo': false,
        'ringtonePath': 'system_ringtone_default',
        'backgroundColor': '#0955fa',
        'actionColor': '#4CAF50',
        'incomingCallNotificationChannelName': 'Incoming Call',
      },
      'ios': <String, dynamic>{
        'iconName': 'CallKitLogo',
        'handleType': 'generic',
        'supportsVideo': true,
        'maximumCallGroups': 2,
        'maximumCallsPerCallGroup': 1,
        'audioSessionMode': 'default',
        'audioSessionActive': true,
        'audioSessionPreferredSampleRate': 44100.0,
        'audioSessionPreferredIOBufferDuration': 0.005,
      },
    };

    await FlutterCallkitIncoming.showCallkitIncoming(
      CallKitParams.fromJson(params),
    );
  }

  void listenToCallEvents() {
    FlutterCallkitIncoming.onEvent.listen((event) async {
      final body = jsonDecode(jsonEncode(event?.body)) as Map<String, dynamic>;

      final callParams = CallKitParams.fromJson(body);
      switch (event!.event) {
        case Event.actionCallAccept:
          await acceptCall(callParams.extra!["chatId"]);
          break;

        case Event.actionCallDecline:
          customSnackBar("Call Declined", type: SnackBarType.error);
          break;

        case Event.actionCallEnded:
          callRepository.updateCallStatus(
            callParams.extra!["chatId"],
            CallState.rejected,
          );
          break;

        default:
          break;
      }
    });
  }
}
