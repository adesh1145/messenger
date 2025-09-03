import 'package:get/get.dart';
import 'package:messenger/features/chat/presentation/call_screen/call_controller.dart';

class CallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CallController(Get.find()));
  }
}
