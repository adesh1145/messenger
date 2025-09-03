import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messenger/features/welcome/splash_controller.dart';

import 'package:messenger/ui/widget/text.dart';

import '../../core/theme/app_images.dart';
import '../../ui/widget/colors.dart';
import '../../ui/widget/svgpicture.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPictureWidget(
              path: AppImages.messageIcon,
              height: 175.h,
              color: blueColor7,
            ),
            Container(height: 20.h),
            TextWidget(text: "Messenger", fontsize: 30),
          ],
        ),
      ),
    );
  }
}
