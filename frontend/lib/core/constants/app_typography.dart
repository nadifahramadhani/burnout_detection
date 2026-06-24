import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String primaryFont = 'Plus Jakarta Sans';
  static const String secondaryFont = 'DM Sans';

  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  static TextStyle get title1 => _primary(
        fontSize: 72,
        lineHeight: 88,
        fontWeight: bold,
      );

  static TextStyle get title2 => _primary(
        fontSize: 64,
        lineHeight: 76,
        fontWeight: bold,
      );

  static TextStyle get title3 => _primary(
        fontSize: 56,
        lineHeight: 68,
        fontWeight: bold,
      );

  static TextStyle get h1 => _primary(
        fontSize: 48,
        lineHeight: 68,
        fontWeight: bold,
      );

  static TextStyle get h2 => _primary(
        fontSize: 40,
        lineHeight: 58,
        fontWeight: bold,
      );

  static TextStyle get h3 => _primary(
        fontSize: 32,
        lineHeight: 48,
        fontWeight: bold,
      );

  static TextStyle get h4 => _primary(
        fontSize: 28,
        lineHeight: 38,
        fontWeight: semiBold,
      );

  static TextStyle get h5 => _primary(
        fontSize: 24,
        lineHeight: 30,
        fontWeight: semiBold,
      );

  static TextStyle get h6 => _primary(
        fontSize: 20,
        lineHeight: 24,
        fontWeight: semiBold,
      );

  static TextStyle get label1 => _primary(
        fontSize: 16,
        lineHeight: 22,
        fontWeight: semiBold,
      );

  static TextStyle get label2 => _primary(
        fontSize: 14,
        lineHeight: 20,
        fontWeight: semiBold,
      );

  static TextStyle get label3 => _primary(
        fontSize: 12,
        lineHeight: 16,
        fontWeight: semiBold,
      );

  static TextStyle get body1 => _secondary(
        fontSize: 18,
        lineHeight: 28,
      );

  static TextStyle get body2 => _secondary(
        fontSize: 16,
        lineHeight: 24,
      );

  static TextStyle get body3 => _secondary(
        fontSize: 14,
        lineHeight: 20,
      );

  static TextStyle get body4 => _secondary(
        fontSize: 12,
        lineHeight: 16,
      );

  static TextStyle get caption1 => _secondary(
        fontSize: 10,
        lineHeight: 12,
      );

  static TextStyle get caption2 => _secondary(
        fontSize: 9,
        lineHeight: 10,
      );

  static TextStyle _primary({
    required double fontSize,
    required double lineHeight,
    FontWeight fontWeight = regular,
  }) {
    return GoogleFonts.plusJakartaSans(
      color: AppColors.dark,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: lineHeight / fontSize,
      letterSpacing: 0,
    );
  }

  static TextStyle _secondary({
    required double fontSize,
    required double lineHeight,
    FontWeight fontWeight = regular,
  }) {
    return GoogleFonts.dmSans(
      color: AppColors.dark,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: lineHeight / fontSize,
      letterSpacing: 0,
    );
  }
}
