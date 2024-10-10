import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static Color get primary => AppColors.sangoRed; // Primary color
  static Color get lightBackground => AppColors.roseDragee; // Background color for light theme
  static Color get hintTextColor => AppColors.verifiedBlack; // Hint text color
  static Color get white => AppColors.white; // White color
  static Color get black => AppColors.erieBlack; // Black color

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: lightBackground,
    brightness: Brightness.light,
    fontFamily: 'Satoshi',

    // Customize Slider theme
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
    ),

    // Customize Input Decorations
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(30),
      hintStyle: TextStyle(
        color: hintTextColor,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: white,
          width: 0.4,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: black,
          width: 0.4,
        ),
      ),
    ),

    // Customize Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}