import 'package:get/get.dart';

import 'chat_controller.dart';

class ChatScreenBinding implements Bindings {
  @override
  void dependencies() {
    final chatId = Get.parameters['chatId']!;
    if (!Get.isRegistered<ChatController>(tag: chatId)) {
      Get.put(
        ChatController(
          chatId: chatId,
          getMessagesusecase: Get.find(),
          sendMessegeUsecase: Get.find(),
        ),
        tag: chatId,
        permanent: true,
      );
    }
  }
}
