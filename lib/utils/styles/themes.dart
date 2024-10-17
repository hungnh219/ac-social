import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static Color get primary => AppColors.sangoRed; // Primary color
  static Color get lightBackground => AppColors.roseDragee; // Background color for light theme
  static Color get hintTextColor => AppColors.noghreiSilver; // Hint text color
  static Color get labelTextColor => AppColors.verifiedBlack; // Label text color
  static Color get white => AppColors.white; // White color
  static Color get black => AppColors.erieBlack; // Black

  static Gradient get mainGradient => const LinearGradient(
    colors: [AppColors.irish, AppColors.lavenderBlueShadow],
  );

  static TextStyle get appLabelStyle => GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: labelTextColor,
      letterSpacing: 0.60
  );

  static TextStyle get appHintStyle => GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: hintTextColor,
      letterSpacing: 0.60
  );

  static TextStyle get headerStyle => GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: white,
  );

  static TextStyle get buttonGradientStyle => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    color: white,
    fontSize: 16,
    height: 0.09,
    letterSpacing: 0.60,
  );


  static final ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: white,
    brightness: Brightness.light,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(),

    // Customize Slider theme
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
    ),

    // Customize Icon theme
    iconTheme: IconThemeData(
      color: white, // Set default color for icons
      size: 24, // Default icon size
    ),

    // Customize Input Decorations
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.chefsHat,
      contentPadding: const EdgeInsets.all(30),
      hintStyle: appHintStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
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