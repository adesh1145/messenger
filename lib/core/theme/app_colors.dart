import 'package:flutter/material.dart';

class AppColors {
  // ---------------- Primary Color Shades ----------------
  static const Color primary = Color.fromRGBO(13, 145, 227, 1); // Base color
  static const Color primary90 = Color.fromRGBO(13, 145, 227, 0.9);
  static const Color primary80 = Color.fromRGBO(13, 145, 227, 0.8);
  static const Color primary70 = Color.fromRGBO(13, 145, 227, 0.7);
  static const Color primary60 = Color.fromRGBO(13, 145, 227, 0.6);
  static const Color primary50 = Color.fromRGBO(13, 145, 227, 0.5);
  static const Color primary40 = Color.fromRGBO(13, 145, 227, 0.4);
  static const Color primary30 = Color.fromRGBO(13, 145, 227, 0.3);
  static const Color primary20 = Color.fromRGBO(13, 145, 227, 0.2);
  static const Color primary10 = Color.fromRGBO(13, 145, 227, 0.1);

  // ---------------- Secondary Color ----------------
  static const Color secondary = Color.fromARGB(255, 0, 13, 252);

  // ---------------- Neutral / Common Colors ----------------
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFEEEEEE);
  static const Color darkGrey = Color(0xFF616161);
  static const Color transparent = Colors.transparent;
  // ---------------- Text Colors ----------------
  static const Color text1 = Color(0xFF212121); // Headings
  static const Color text2 = Color(0xFF424242); // Body text
  static const Color text3 = Color(0xFF757575); // Captions / Hints
  // ---------------- Support / Semantic Colors ----------------
  static const Color disabled = Color(0xFFBDBDBD); // Disabled state
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFFC107); // Amber
  static const Color error = Color(0xFFF44336); // Red
  static const Color info = Color(0xFF2196F3); // Blue

  // ---------------- Gradients ----------------
  static const Gradient gradient1 = LinearGradient(
    begin: Alignment(-1, -1),
    end: Alignment(1, 1),
    colors: [
      Color.fromRGBO(245, 226, 228, 1),
      Color.fromRGBO(154, 217, 219, 1),
    ],
  );

  static const Gradient gradient2 = LinearGradient(
    begin: Alignment(-1, -1),
    end: Alignment(1, 1),
    colors: [
      Color.fromRGBO(213, 187, 189, 1),
      Color.fromRGBO(167, 198, 117, 1),
    ],
  );
}
