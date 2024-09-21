import 'package:flutter/material.dart';

class AppColors {
  static LinearGradient buttonColor = LinearGradient(
    colors: [
      Color(0xFFC09960),
      Color(0xFFBC935A),
      Color(0xFFB88C55),
      Color(0xFFB48750),
      Color(0xFFAE7D48),
      Color(0xFFA7713F),
      Color(0xFFA26837),
      Color(0xFF9C6031),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static LinearGradient buttonColorSubscription = LinearGradient(
    colors: [
      Color(0xFFCC19B61),
      Color(0xFFB48650),
      Color(0xFFB48650),
      Color(0xFFAE7D48),
      Color(0xFFA7713F),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient whiteColorGradient = LinearGradient(
    colors: [
      Colors.white, // Starting color
      Color(0xFFF5F5F5), // Slightly off-white
      Color(0xFFE0E0E0), // Light grey
      Color(0xFFBDBDBD),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static LinearGradient blackColorGradient = LinearGradient(
    colors: [
      Colors.black, // Starting color
      Color(0xFF000000), // Slightly off-white
      Color(0xFF000000), // Light grey
      Color(0xFF000000),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static Color chatColor=Color(0xFF333333);
  static Color blackColor=Color(0xFF1D1D1D);
  static Color appColor=Color(0xFFA7713F);
}
