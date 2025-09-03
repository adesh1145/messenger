import 'package:get/get.dart';
import 'package:messenger/features/auth/presentation/login_screen/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(Get.find()));
  }
}
