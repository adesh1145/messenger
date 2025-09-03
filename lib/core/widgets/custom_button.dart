import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/core/theme/app_decoration.dart';
import 'package:messenger/core/theme/app_style.dart';
import 'package:messenger/core/widgets/custom_loader.dart';
import 'package:messenger/core/widgets/custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onTap,
    this.child,
    this.text = "",
    this.alignment,
    this.autofocus = false,
    this.isExpanded = true,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.animationDuration,
    this.borderWidth,
    this.elevation,
    this.padding,
    this.textStyle,
    this.isLoading = false,
  });
  final String text;
  final Widget? child;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final bool autofocus;
  final Color? backgroundColor;
  final Color? borderColor;
  final AlignmentGeometry? alignment;
  final double? elevation;
  final double? borderWidth;
  final bool isExpanded;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Duration? animationDuration;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: isLoading ? () {} : onTap,
                  autofocus: autofocus,
                  style: TextButton.styleFrom(
                    // maximumSize: Size(double.maxFinite, 40.h),
                    backgroundColor: backgroundColor,
                    disabledBackgroundColor: AppColors.disabled,
                    alignment: alignment,
                    elevation: elevation == null ? null : (elevation),
                    padding:
                        padding ??
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 9.h),

                    shape: borderRadius == null
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                          )
                        : RoundedRectangleBorder(borderRadius: borderRadius!),
                    animationDuration: animationDuration,
                    // enableFeedback:
                  ),
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularLoader(
                              color: AppColors.white,
                              radius: 16.sp,
                              strokeWidth: 3,
                            ),
                            SizedBox(width: 12.w),
                            CustomText(
                              "Loading...",
                              style: textStyle ?? AppStyle.roboto16White700,
                            ),
                          ],
                        )
                      : child ??
                            CustomText(
                              text,
                              style: textStyle ?? AppStyle.roboto16White700,
                            ),
                ),
              ),
            ],
          )
        : ElevatedButton(
            onPressed: isLoading ? () {} : onTap,
            autofocus: autofocus,
            style: TextButton.styleFrom(
              // maximumSize: Size(double.maxFinite, 40.h),
              backgroundColor: backgroundColor,
              alignment: alignment,
              elevation: elevation == null ? null : (elevation),
              padding:
                  padding ??
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 9.h),

              shape: borderRadius == null
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                    )
                  : RoundedRectangleBorder(borderRadius: borderRadius!),
              animationDuration: animationDuration,
              // enableFeedback:
            ),
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularLoader(
                        color: AppColors.white,
                        radius: 16.sp,
                        strokeWidth: 3,
                      ),
                      SizedBox(width: 12.w),
                      CustomText(
                        "Loading...",
                        style: textStyle ?? AppStyle.roboto16White700,
                      ),
                    ],
                  )
                : child ??
                      CustomText(
                        text,
                        style: textStyle ?? AppStyle.roboto16White700,
                      ),
          );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    this.onTap,
    this.child,
    this.text = "",
    this.alignment,
    this.autofocus = false,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.animationDuration,
    this.borderWidth,
    this.elevation,
    this.isExpanded = true,
    this.padding,
    this.textStyle,
  });
  final bool isExpanded;
  final String text;
  final Widget? child;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final bool autofocus;
  final Color? backgroundColor;
  final Color? borderColor;
  final AlignmentGeometry? alignment;
  final double? elevation;
  final double? borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Duration? animationDuration;
  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onTap,
                  autofocus: autofocus,
                  style: TextButton.styleFrom(
                    // maximumSize: Size(double.maxFinite, 40.h),
                    backgroundColor: backgroundColor,
                    alignment: alignment,
                    elevation: elevation == null ? null : (elevation),
                    padding:
                        padding ??
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 9.h),
                    side: BorderSide(color: borderColor ?? AppColors.primary),

                    shape: borderRadius == null
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                          )
                        : RoundedRectangleBorder(borderRadius: borderRadius!),
                    animationDuration: animationDuration,
                    // enableFeedback:
                  ),
                  child:
                      child ??
                      CustomText(
                        text,
                        style: textStyle ?? AppStyle.roboto16PrimaryW700,
                      ),
                ),
              ),
            ],
          )
        : OutlinedButton(
            onPressed: onTap,
            autofocus: autofocus,
            style: TextButton.styleFrom(
              // maximumSize: Size(double.maxFinite, 40.h),
              backgroundColor: backgroundColor,
              alignment: alignment,
              elevation: elevation == null ? null : (elevation),
              padding:
                  padding ??
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 9.h),
              side: BorderSide(color: borderColor ?? AppColors.primary),

              shape: borderRadius == null
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                    )
                  : RoundedRectangleBorder(borderRadius: borderRadius!),
              animationDuration: animationDuration,
              // enableFeedback:
            ),
            child:
                child ??
                CustomText(
                  text,
                  style: textStyle ?? AppStyle.roboto16PrimaryW700,
                ),
          );
  }
}

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon({
    super.key,
    this.onTap,
    this.text = "",
    this.alignment,
    this.autofocus = false,
    this.isTextCenter = true,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.animationDuration,
    this.elevation,
    this.padding,
    this.textStyle,
    this.suffixWidget,
    this.isExpanded = true,
    this.prefixWidget,
  });
  final String text;

  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final bool autofocus;
  final bool isExpanded;
  final Color? backgroundColor;
  final Color? borderColor;
  final AlignmentGeometry? alignment;
  final double? elevation;
  final double? borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isTextCenter;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Duration? animationDuration;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      autofocus: autofocus,
      style: TextButton.styleFrom(
        // maximumSize: Size(double.maxFinite, 40.h),
        backgroundColor: backgroundColor ?? AppColors.primary,
        alignment: alignment,
        elevation: elevation,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 9.h),
        textStyle: textStyle,
        shape: borderRadius == null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              )
            : RoundedRectangleBorder(borderRadius: borderRadius!),
        animationDuration: animationDuration,
        // enableFeedback:
      ),
      child: _buildButtonWithOrWithIcon(isExpanded),
    );
  }

  _buildButtonWithOrWithIcon(bool isExpanded) {
    return Row(
      mainAxisAlignment: isExpanded
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (isTextCenter) const SizedBox(),
        if (prefixWidget != null) prefixWidget!,
        Center(
          child: CustomText(
            text,
            style: textStyle ?? AppStyle.roboto16White700,
          ),
        ),
        SizedBox(width: 12.w),
        if (prefixWidget == null)
          suffixWidget ?? Icon(Icons.chevron_right, color: AppColors.white),
      ],
    );
  }
}

class CustomOutlinedButtonWithIcon extends StatelessWidget {
  const CustomOutlinedButtonWithIcon({
    super.key,
    this.onTap,
    this.child,
    this.text = "",
    this.alignment,
    this.autofocus = false,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.animationDuration,
    this.elevation,
    this.padding,
    this.textStyle,
    this.suffixWidget,
    this.isTextCenter = true,
  });
  final String text;
  final Widget? child;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final bool autofocus;
  final Color? backgroundColor;
  final Color? borderColor;
  final AlignmentGeometry? alignment;
  final double? elevation;
  final double? borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isTextCenter;
  final Widget? suffixWidget;
  final Duration? animationDuration;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      autofocus: autofocus,
      style: TextButton.styleFrom(
        // maximumSize: Size(double.maxFinite, 40.h),
        backgroundColor: backgroundColor == null ? null : (backgroundColor),
        alignment: alignment,
        elevation: elevation == null ? null : (elevation),
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 9.h),

        shape: borderRadius == null
            ? null
            : RoundedRectangleBorder(borderRadius: borderRadius!),
        animationDuration: animationDuration,
        // enableFeedback:
      ),
      child: _buildButtonWithOrWithIcon(),
    );
  }

  Widget _buildButtonWithOrWithIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isTextCenter) const SizedBox(),
        Center(
          child: CustomText(
            text,
            style: textStyle ?? AppStyle.roboto16White700,
          ),
        ), //
        suffixWidget ?? Icon(Icons.chevron_right, color: AppColors.white),
      ],
    );
  }
}
