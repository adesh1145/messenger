import 'package:get/instance_manager.dart';
import 'package:messenger/features/chat/presentation/chat_list_screen/chat_list_controller.dart';

class ChatListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ChatListController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
  }
}
