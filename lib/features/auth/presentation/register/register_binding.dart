import 'package:get/get.dart';
import 'package:messenger/features/auth/presentation/register/registration_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(registerUseCase: Get.find()));
  }
}
