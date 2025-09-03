import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/core/config/app_routes.dart';
import 'package:messenger/core/widgets/custom_snack_bar.dart';
import 'package:messenger/features/auth/domain/usecase/login_usecase.dart';
import 'package:messenger/features/profile/presentation/profile_controller.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    final result = await loginUseCase(
      LoginParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    result.fold((l) => customSnackBar(l.message, type: SnackBarType.error), (
      r,
    ) async {
      await Get.find<ProfileController>().getProfile();
    });
    isLoading.value = false;
  }
}
