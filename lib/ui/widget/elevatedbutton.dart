// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

import 'colors.dart';
import 'text.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    this.text,
    this.icon,
    this.onpressed,
    this.textcolor,
    this.fontsize = 20,
    this.borderRadius,
    this.height,
    this.width,
    this.fontweight,
  });

  final String? text;
  final Widget? icon;
  final VoidCallback? onpressed;
  final Color? textcolor;
  final double fontsize;
  final double? height;
  final double? width;
  final double? borderRadius;
  final FontWeight? fontweight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        height: height,
        width: width,
        decoration: borderRadius != null
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius!),
                color: blueColor7,
              )
            : BoxDecoration(),
        child: Center(
          child: icon == null
              ? TextWidget(
                  text: text!,
                  fontsize: fontsize,
                  textcolor: textcolor,
                  fontweight: fontweight,
                )
              : Row(
                  children: [
                    icon!,
                    TextWidget(
                      text: text!,
                      fontweight: fontweight!,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
