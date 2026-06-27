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
                  // Cari bagian Container statusText di lib/core/widgets/journal_card.dart
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
                        fontWeight: FontWeight.bold,
                        // LOGIKA WARNA TEKS: Gunakan putih jika statusColor gelap, hitam jika terang
                        color:
                            (statusColor == AppColors.burnoutHigh ||
                                statusColor == AppColors.burnoutCritical)
                            ? Colors.white
                            : AppColors.dark,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // TEKS KONTEN JURNAL (Sekarang menggunakan Expandable Widget)
          ExpandableJournalText(text: content),

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
                _buildStatBox(
                  'Sosial',
                  socialValue,
                  'x',
                ), // Diubah ke 'x' (frekuensi istirahat) sesuai diskusi sebelumnya
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

// ==========================================
// WIDGET BARU: Teks Jurnal yang Bisa Buka-Tutup
// ==========================================
class ExpandableJournalText extends StatefulWidget {
  final String text;

  const ExpandableJournalText({super.key, required this.text});

  @override
  State<ExpandableJournalText> createState() => _ExpandableJournalTextState();
}

class _ExpandableJournalTextState extends State<ExpandableJournalText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Batas jumlah karakter sebelum dipotong
    const int maxLength = 90;
    final String fullText = widget.text;

    // Jika teksnya memang sudah pendek, tampilkan biasa tanpa tombol
    if (fullText.length <= maxLength) {
      return Text(
        '“$fullText”',
        style: AppTypography.body2.copyWith(
          color: AppColors.lav900,
          fontSize: 12,
        ),
      );
    }

    // Teks yang akan ditampilkan berdasarkan status isExpanded
    final String displayText = isExpanded
        ? fullText
        : '${fullText.substring(0, maxLength)}...';

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '“$displayText” ',
              style: AppTypography.body2.copyWith(
                color: AppColors.lav900,
                fontSize: 12,
              ),
            ),
            TextSpan(
              text: isExpanded ? 'Tutup' : 'Selengkapnya',
              style: AppTypography.body2.copyWith(
                color: AppColors
                    .mint900, // Warna hijau mint agar terlihat bisa diklik
                fontSize: 11,
                fontWeight: AppTypography.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
