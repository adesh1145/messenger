import 'package:messenger/core/theme/app_colors.dart';

import '../../core/theme/app_images.dart';
import 'colors.dart';

import 'package:flutter/material.dart';

import 'svgpicture.dart';
import 'text.dart';

class TopPartOfScreen extends StatelessWidget {
  const TopPartOfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Container(
        color: AppColors.primary70,
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPictureWidget(
              path: AppImages.messageIcon,
              height: 125,
              color: Colors.white,
            ),
            const TextWidget(
              text: " Messenger",
              fontsize: 30,
              textcolor: Colors.white,
              fontweight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
