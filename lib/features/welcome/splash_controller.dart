import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:messenger/core/config/app_routes.dart';
import 'package:messenger/features/profile/presentation/profile_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 1), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        await Get.find<ProfileController>().getProfile();
      } else {
        Get.offAndToNamed(AppRoutes.loginScreen);
      }
    });
  }
}
