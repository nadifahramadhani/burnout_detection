import 'package:flutter/material.dart';
// Pastikan path import ini sesuai dengan letak folder constants kamu
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
  // Gunakan variabel dari AppColors agar terpusat dan konsisten
  static const senang = MoodData(
    label: 'Senang',
    color: AppColors.burnoutLow, // Sama dengan Color(0xFFCAE894)
    imagePath: 'assets/images/happy.png',
  );

  static const biasaAja = MoodData(
    label: 'Biasa Aja',
    color: AppColors.burnoutMedium, // Sama dengan Color(0xFFF5D87A)
    imagePath: 'assets/images/flat.png',
  );

  static const sedih = MoodData(
    label: 'Sedih',
    color: AppColors.burnoutHigh, // Sama dengan Color(0xFFE8896A)
    imagePath: 'assets/images/sad.png',
  );

  static const marah = MoodData(
    label: 'Marah',
    color: AppColors.burnoutCritical, // Sama dengan Color(0xFFD14040)
    imagePath: 'assets/images/anggry.png',
  );

  static const List<MoodData> allMoods = [senang, biasaAja, sedih, marah];

  static MoodData getMood(String? label) {
    if (label == null) return biasaAja; // Default jika kosong

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
        return biasaAja; // Fallback jika teks tidak dikenali
    }
  }
}
