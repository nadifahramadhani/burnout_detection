import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // =========================
  // PRIMARY (Mint)
  // =========================

  static const Color mint50 = Color(0xFFEEF8DC);
  static const Color mint200 = Color(0xFFCAE894);
  static const Color mint400 = Color(0xFF8DC94A);
  static const Color mint600 = Color(0xFF4A8C1C);
  static const Color mint900 = Color(0xFF224C25);

  static const Color primary = mint400;
  static const Color primaryDark = mint600;
  static const Color primaryLight = mint50;

  // =========================
  // SECONDARY (Lavender)
  // =========================

  static const Color lav50 = Color(0xFFF2EEF9);
  static const Color lav200 = Color(0xFFD4C4F0);
  static const Color lav400 = Color(0xFFAF95E2);
  static const Color lav600 = Color(0xFF6B5EA8);
  static const Color lav900 = Color(0xFF3E0B5E);

  static const Color secondary = lav400;
  static const Color secondaryDark = lav600;
  static const Color secondaryLight = lav50;

  // =========================
  // NEUTRAL
  // =========================

  static const Color background = Color(0xFFF9F9F9);
  static const Color surface = Color(0xFFEDE9F8);
  static const Color border = Color(0xFFD8D3EC);
  static const Color muted = Color(0xFF9B8FC4);
  static const Color dark = Color(0xFF1A1A2E);

  // =========================
  // BASIC
  // =========================

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // =========================
  // BURNOUT LEVEL
  // =========================

  static const Color burnoutLow = Color(0xFFCAE894);
  static const Color burnoutMedium = Color(0xFFF5D87A);
  static const Color burnoutHigh = Color(0xFFE8896A);
  static const Color burnoutCritical = Color(0xFFD14040);
}
