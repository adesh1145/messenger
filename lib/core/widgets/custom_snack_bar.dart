import 'package:get/get.dart';
import 'package:messenger/core/theme/app_colors.dart';

enum SnackBarType { error, success, warning }

void customSnackBar(
  String message, {
  String? title,
  SnackBarType type = SnackBarType.success,
}) {
  Get.snackbar(
    title ??
        (type == SnackBarType.error
            ? 'Error'
            : type == SnackBarType.warning
            ? 'Warning'
            : 'Success'),
    message,
    snackPosition: SnackPosition.BOTTOM,
    isDismissible: true,
    backgroundColor: type == SnackBarType.error
        ? AppColors.error
        : type == SnackBarType.warning
        ? AppColors.warning
        : AppColors.success,
    colorText: AppColors.white,
  );
}
