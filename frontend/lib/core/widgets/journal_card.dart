import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

class JournalCard extends StatelessWidget {
  final String date;
  final String moodLabel;
  final String content;
  final String statusText;
  final Color statusColor;

  // Nilai-nilai statistik kecil
  final String sleepValue;
  final String workoutValue;
  final String focusValue;
  final String socialValue;
  final String caffeineValue;

  const JournalCard({
    super.key,
    required this.date,
    required this.moodLabel,
    required this.content,
    required this.statusText,
    required this.statusColor,
    required this.sleepValue,
    required this.workoutValue,
    required this.focusValue,
    required this.socialValue,
    required this.caffeineValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lav50, // Latar card ungu sangat muda
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER CARD: Mood Icon & Text (Kiri) + Tanggal & Status (Kanan)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Bagian Kiri (Icon + Mood)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    // Lingkaran Placeholder Icon Mood
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mint200, // Warna dummy
                      ),
                      // child: Icon(Icons.emoji_emotions, size: 16), // Tambahkan icon asli nanti
                    ),
                    const SizedBox(width: 8),
                    Text(
                      moodLabel,
                      style: AppTypography.h6.copyWith(
                        fontSize: 14,
                        color: AppColors.dark,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Bagian Kanan (Tanggal + Pill Status)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    date,
                    style: AppTypography.body2.copyWith(
                      fontSize: 10,
                      color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: AppTypography.body2.copyWith(
                        fontSize: 10,
                        fontWeight: AppTypography.bold,
                        // Jika warna merah gelap, teks putih. Jika hijau/kuning terang, teks hitam
                        color: statusColor == AppColors.burnoutHigh
                            ? Colors.white
                            : const Color(0xFF604B08),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // TEKS KONTEN JURNAL
          Text(
            '“$content”',
            style: AppTypography.body2.copyWith(
              color: AppColors.lav900,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),

          // BOX STATISTIK (Bisa digeser horizontal jika layar HP terlalu kecil)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStatBox('Jam Tidur', sleepValue, 'jm'),
                const SizedBox(width: 8),
                _buildStatBox('Olahraga', workoutValue, 'mnt'),
                const SizedBox(width: 8),
                _buildStatBox('Jam Fokus', focusValue, 'jm'),
                const SizedBox(width: 8),
                _buildStatBox('Sosial', socialValue, 'jm'),
                const SizedBox(width: 8),
                _buildStatBox('Kafein', caffeineValue, 'mg'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk membuat box putih statistik di bawah
  Widget _buildStatBox(String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTypography.body2.copyWith(
              fontSize: 10,
              color: AppColors.lav900, // Warna teks ungu tua
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTypography.h6.copyWith(
                  fontSize: 14,
                  fontWeight: AppTypography.bold,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: AppTypography.body2.copyWith(
                  fontSize: 10,
                  color: AppColors.dark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
