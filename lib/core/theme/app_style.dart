import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyle {
  static TextScaler get textScalfactor =>
      TextScaler.linear(ScreenUtil().textScaleFactor);
  static TextStyle get roboto14w400 =>
      GoogleFonts.roboto(fontSize: 14.sp, fontWeight: FontWeight.w400);
  static TextStyle get roboto13w400 =>
      GoogleFonts.roboto(fontSize: 13.sp, fontWeight: FontWeight.w400);

  static TextStyle get roboto14Text1W500 => GoogleFonts.roboto(
    color: AppColors.text1,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle get roboto16White700 => GoogleFonts.roboto(
    color: AppColors.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle get roboto16PrimaryW700 => GoogleFonts.roboto(
    color: AppColors.primary,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle get roboto14Text2w400 => GoogleFonts.roboto(
    color: AppColors.text2,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
}
