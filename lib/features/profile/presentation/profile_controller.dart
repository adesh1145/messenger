import 'package:get/get.dart';
import 'package:messenger/core/config/app_routes.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';
import 'package:messenger/features/profile/domain/usecase/create_profile_usecase.dart';
import 'package:messenger/features/profile/domain/usecase/get_profile_usecase.dart';
import 'package:messenger/features/profile/domain/usecase/logout_usecase.dart';
import 'package:messenger/features/profile/domain/usecase/update_profile_usecase.dart';

import '../../../core/widgets/custom_snack_bar.dart';

class ProfileController extends GetxController {
  final UpdateProfileUsecase _updateProfileUsecase;
  final GetProfileUsecase _getProfileUsecase;
  final CreateProfileUsecase _createProfileUsecase;
  final LogoutUsecase _logoutUsecase;
  ProfileController(
    this._updateProfileUsecase,
    this._getProfileUsecase,
    this._createProfileUsecase,
    this._logoutUsecase,
  );

  RxBool isLoading = false.obs;
  Rx<User> user = Rx<User>(User(uid: '', email: '', name: '', photoUrl: ''));
  final arg = Get.arguments;

  void createProfile(
    String name,
    String description, [
    String photoUrl = '',
  ]) async {
    isLoading.value = true;
    final updatedUser = User(
      uid: user.value.uid,
      email: user.value.email,
      name: name,
      photoUrl: photoUrl,
      phone: user.value.phone,
      description: description,
    );
    await _createProfileUsecase.call(updatedUser).then((value) {
      value.fold((l) => customSnackBar(l.message, type: SnackBarType.error), (
        r,
      ) {
        user.value = updatedUser;

        customSnackBar(
          "Profile Created successfully",
          type: SnackBarType.success,
        );
        Get.offAllNamed(AppRoutes.chatListScreen);
      });
    });

    isLoading.value = false;
  }

  void updateProfile(
    String name,
    String description, [
    String photoUrl = '',
  ]) async {
    isLoading.value = true;
    final updatedUser = User(
      uid: user.value.uid,
      email: user.value.email,
      name: name,
      photoUrl: photoUrl,
      phone: user.value.phone,
      description: description,
    );
    await _updateProfileUsecase.call(updatedUser).then((value) {
      value.fold((l) => customSnackBar(l.message, type: SnackBarType.error), (
        r,
      ) {
        user.value = updatedUser;
        customSnackBar(
          "Profile Updated successfully",
          type: SnackBarType.success,
        );
      });
    });

    isLoading.value = false;
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    await _getProfileUsecase.call().then((value) {
      value.fold(
        (l) {
          customSnackBar(l.message, type: SnackBarType.error);
          Get.offAllNamed(
            AppRoutes.updateProfileScreen,
            arguments: {"isFromRegister": true},
          );
        },
        (r) {
          user.value = r;
          Get.offAndToNamed(AppRoutes.chatListScreen);
        },
      );
    });
    isLoading.value = false;
  }

  void logout() async {
    Get.offAllNamed(AppRoutes.loginScreen);
    await _logoutUsecase.call().then((value) {
      value.fold((l) => customSnackBar(l.message, type: SnackBarType.error), (
        r,
      ) {
        user.value = User(uid: '', email: '', name: '', photoUrl: '');
      });
    });
  }
}
