// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.hint,
    this.label,
    this.icon,
    this.prfixIcon,
    this.suffixIcon,
    this.borderRadius = 0,
    this.borderColor = Colors.black,
    this.focusBorderColor = const Color.fromRGBO(13, 145, 227, 0.7),
    this.obscureText = false,
    this.textInputType = TextInputType.name,
    // this.maxLength = 20,
    this.controller,
    this.validator,
    this.onChanged,
    this.fontSize = 15,
    this.initialValue,
    this.readOnly = false,
  });

  final String? hint;
  final String? initialValue;
  final Text? label;
  final Widget? icon;
  final Widget? prfixIcon;
  final Widget? suffixIcon;
  final double borderRadius;
  final Color borderColor;
  final Color focusBorderColor;
  final bool obscureText;
  final double fontSize;
  final TextInputType textInputType;
  final bool readOnly;
  // final int maxLength;
  final TextEditingController? controller;
  // final  validator
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hint,
        label: label,
        icon: icon,
        iconColor: focusBorderColor,
        prefixIcon: prfixIcon,
        suffixIcon: suffixIcon,
        prefixIconColor: focusBorderColor,
        contentPadding: EdgeInsets.all(0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 1.5, color: borderColor),
        ),
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 2, color: borderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 2, color: focusBorderColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 2, color: borderColor),
        ),
      ),
      cursorHeight: 20,
      keyboardType: textInputType,
      onChanged: onChanged,
      // maxLength: maxLength,
      style: TextStyle(fontSize: fontSize),
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      readOnly: readOnly,
    );
  }
}
