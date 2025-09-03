import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/core/config/app_routes.dart';
import 'package:messenger/core/widgets/custom_snack_bar.dart';
import 'package:messenger/features/auth/domain/usecase/register_usecase.dart';

class RegisterController extends GetxController {
  final RegisterUsecase registerUseCase;
  RegisterController({required this.registerUseCase});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxBool isLoading = false.obs;
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    isLoading.value = true;
    final result = await registerUseCase(
      RegisterParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    result.fold((l) => customSnackBar(l.message, type: SnackBarType.error), (
      r,
    ) {
      Get.offAllNamed(
        AppRoutes.updateProfileScreen,
        arguments: {"isFromRegister"},
      );
      customSnackBar(
        "Account created successfully",
        type: SnackBarType.success,
      );
    });
    isLoading.value = false;
  }
}
