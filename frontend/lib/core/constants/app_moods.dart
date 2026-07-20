import 'package:flutter/material.dart';

import 'app_colors.dart';

class MoodData {
  final String label;
  final Color color;
  final String imagePath;

  const MoodData({
    required this.label,
    required this.color,
    required this.imagePath,
  });
}

class AppMoods {

  static const senang = MoodData(
    label: 'Senang',
    color: AppColors.burnoutLow,
    imagePath: 'assets/images/happy.png',
  );

  static const biasaAja = MoodData(
    label: 'Biasa Aja',
    color: AppColors.burnoutMedium,
    imagePath: 'assets/images/flat.png',
  );

  static const sedih = MoodData(
    label: 'Sedih',
    color: AppColors.burnoutHigh,
    imagePath: 'assets/images/sad.png',
  );

  static const marah = MoodData(
    label: 'Marah',
    color: AppColors.burnoutCritical,
    imagePath: 'assets/images/anggry.png',
  );

  static const List<MoodData> allMoods = [senang, biasaAja, sedih, marah];

  static MoodData getMood(String? label) {
    if (label == null) return biasaAja;

    switch (label.toLowerCase()) {
      case 'senang':
        return senang;
      case 'biasa aja':
        return biasaAja;
      case 'sedih':
        return sedih;
      case 'marah':
        return marah;
      default:
        return biasaAja;
    }
  }
}
