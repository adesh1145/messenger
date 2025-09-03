import 'package:flutter/material.dart';
import 'package:messenger/core/theme/app_style.dart';

class CustomText extends StatelessWidget {
  CustomText(
    this.text, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.center,
    this.textDirection,
    this.locale,
    this.softWrap = true,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
  });

  final String text;
  final TextStyle? style;

  final StrutStyle? strutStyle;

  final TextAlign? textAlign;

  final TextDirection? textDirection;

  final Locale? locale;

  final bool softWrap;

  final TextOverflow overflow;

  final TextScaler textScaler = AppStyle.textScalfactor;

  final int? maxLines;

  final String? semanticsLabel;

  final TextWidthBasis? textWidthBasis;

  final Color? selectionColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      selectionColor: selectionColor,
      key: key,
      semanticsLabel: semanticsLabel,
      style: style,
    );
  }
}
