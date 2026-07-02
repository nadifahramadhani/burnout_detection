import 'package:flutter/material.dart';
import '../constants/app_typography.dart';
import '../constants/app_moods.dart';

class MoodItemWidget extends StatelessWidget {
  final MoodData mood;
  final bool isSelected;
  final VoidCallback? onTap; // Untuk interaksi jika bisa diklik

  const MoodItemWidget({
    super.key,
    required this.mood,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Lingkaran background + Karakter
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: mood.color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: Colors.black45,
                      width: 2,
                    ) // Indikator jika dipilih
                  : null,
            ),
            child: Image.asset(mood.imagePath, fit: BoxFit.contain),
          ),
          const SizedBox(height: 8),

          // Label teks
          Text(
            mood.label,
            style: AppTypography.body3.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
