import 'dart:async';
import 'package:get/get.dart';
import 'package:messenger/core/utils/enums.dart';
import 'package:messenger/core/widgets/custom_snack_bar.dart';
import 'package:messenger/features/chat/domain/entities/messege.dart';
import 'package:messenger/features/chat/domain/usecase/get_meesege.dart';
import 'package:messenger/features/chat/domain/usecase/send_messege_usecase.dart';
import 'package:messenger/features/profile/presentation/profile_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/config/app_routes.dart';

class ChatController extends GetxController {
  final String chatId;
  final GetMeesegeusecase getMessagesusecase;
  final SendMessegeUsecase sendMessegeUsecase;
  final ProfileController profileController = Get.find();

  ChatController({
    required this.chatId,
    required this.getMessagesusecase,
    required this.sendMessegeUsecase,
  });

  final RxList<Message> messages = <Message>[].obs;

  StreamSubscription<List<Message>>? _messageSubscription;

  @override
  void onInit() {
    super.onInit();

    _startMessageListener();
  }

  @override
  void onClose() {
    _messageSubscription?.cancel();
    super.onClose();
  }

  void _startMessageListener() {
    _messageSubscription = getMessagesusecase(chatId).listen((newMessages) {
      messages.assignAll(newMessages);
    });
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    final user = profileController.user.value;
    final newMessage = Message(
      id: const Uuid().v4(),
      content: content,
      type: MessageType.text,
      createdAt: DateTime.now(),
      senderId: user.uid,
    );

    await sendMessegeUsecase(
      SendMessegeParams(chatId: chatId, messege: newMessage),
    );
  }

  void startCall() async {
    // Check and take Audio Video Call Permission,

    var cameraPermission = await Permission.camera.request();
    var microphonePermission = await Permission.microphone.request();

    if (cameraPermission.isGranted && microphonePermission.isGranted) {
      Get.toNamed(
        AppRoutes.callScreen,
        arguments: {
          'uid': profileController.user.value.uid,
          'name': profileController.user.value.name,
          'roomId': "video_call_$chatId",
          'isCreator': true,
        },
      );
    } else {
      customSnackBar(
        "Audio Video Call Permission not granted",
        type: SnackBarType.error,
      );
    }
  }

  void acceptCall() async {
    // Check and take Audio Video Call Permission,

    var cameraPermission = await Permission.camera.request();
    var microphonePermission = await Permission.microphone.request();

    if (cameraPermission.isGranted && microphonePermission.isGranted) {
      Get.toNamed(
        AppRoutes.callScreen,
        arguments: {
          'uid': profileController.user.value.uid,
          'name': profileController.user.value.name,
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
}
