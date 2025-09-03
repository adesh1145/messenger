// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.fontsize,
    this.fontweight,
    this.fontstyle,
    this.textcolor,
    this.textOverflow,
  });

  final String text;
  final double? fontsize;
  final FontStyle? fontstyle;
  final FontWeight? fontweight;
  final Color? textcolor;
  final TextOverflow? textOverflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        fontWeight: fontweight,
        fontStyle: fontstyle,
        color: textcolor,
        overflow: textOverflow,
      ),
    );
  }
}
