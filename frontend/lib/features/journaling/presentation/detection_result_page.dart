// lib/features/detection/presentation/detection_result_page.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_moods.dart';
import '../models/detection_result_model.dart';
import '../../home/presentation/main_page.dart';

class DetectionResultPage extends StatelessWidget {
  final DetectionResultModel resultData;

  const DetectionResultPage({super.key, required this.resultData});

  @override
  Widget build(BuildContext context) {
    // Ambil tanggal dari data jurnal jika ada, kalau kosong gunakan string default
    final String currentDate = resultData.journal['created_at'] != null
        ? resultData.journal['created_at'].toString().split('T')[0]
        : 'Tidak diketahui';

    return Scaffold(
      backgroundColor: AppColors.secondaryLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(currentDate),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  _buildBurnoutRiskCard(resultData.hasilDeteksi),
                  const SizedBox(height: 16),
                  _buildFeltMoodCard(resultData.journal),
                  const SizedBox(height: 16),
                  _buildLifestyleCard(resultData.lifestyle),
                  const SizedBox(height: 32),
                  _buildActionButtons(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String date) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
      decoration: const BoxDecoration(
        color: AppColors.mint900,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hasil Deteksi Kondisimu',
            style: AppTypography.h6.copyWith(
              color: Colors.white,
              fontWeight: AppTypography.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: AppTypography.body2.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBurnoutRiskCard(Map<String, dynamic> deteksi) {
    // --- PERBAIKAN DI SINI ---
    // Menggunakan double.tryParse agar aman meskipun backend mengirim format String
    double skor = 0.0;
    if (deteksi['burnout_score'] != null) {
      skor = double.tryParse(deteksi['burnout_score'].toString()) ?? 0.0;
    }
    double persenLingkaran = skor / 100;

    String level = deteksi['burnout_level'] ?? 'Tidak Diketahui';
    Color statusColor = AppColors.burnoutHigh;
    if (level == 'Aman dan Sehat' || level == 'Mulai Penat') {
      statusColor = const Color(0xFFCAE894);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Resiko Burnout',
                style: AppTypography.h6.copyWith(
                  color: AppColors.dark,
                  fontWeight: AppTypography.bold,
                  fontSize: 16,
                ),
              ),
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
                  level,
                  style: AppTypography.body2.copyWith(
                    color: statusColor == AppColors.burnoutHigh
                        ? Colors.white
                        : AppColors.dark,
                    fontWeight: AppTypography.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '“Ayok istirahat sebentar, jangan terlalu dipaksa ya”',
            style: AppTypography.body2.copyWith(color: AppColors.dark),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: persenLingkaran,
                    strokeWidth: 14,
                    backgroundColor: statusColor.withOpacity(0.2),
                    color: statusColor,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$skor%',
                      style: AppTypography.h6.copyWith(
                        color: AppColors.dark,
                        fontWeight: AppTypography.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      level.replaceAll('Burnout ', ''),
                      style: AppTypography.body2.copyWith(
                        color: AppColors.dark,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFeltMoodCard(Map<String, dynamic> journal) {
    // 1. AMBIL TEKS DARI BACKEND, LALU UBAH JADI OBJEK MOOD
    final moodLabel = journal['mood'] ?? 'Biasa Aja';
    final moodData = AppMoods.getMood(moodLabel);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Yang kamu rasakan',
                style: AppTypography.h6.copyWith(
                  color: AppColors.dark,
                  fontWeight: AppTypography.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  // 2. UBAH CONTAINER KOSONG MENJADI GAMBAR MOOD
                  Container(
                    width:
                        32, // Dibesarkan sedikit dari 24 ke 32 agar gambarnya terlihat
                    height: 32,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: moodData.color, // Warna dinamis
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(moodData.imagePath), // Gambar karakter
                  ),
                  const SizedBox(width: 8),
                  Text(
                    moodData.label, // Teks yang rapi dari AppMoods
                    style: AppTypography.body2.copyWith(
                      color: AppColors.dark,
                      fontWeight: AppTypography.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpandableJournalText(
              text: journal['text_jurnal'] ?? 'Tidak ada data jurnal',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifestyleCard(Map<String, dynamic> lifestyle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pola hidup kamu',
            style: AppTypography.h6.copyWith(
              color: AppColors.dark,
              fontWeight: AppTypography.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Produktifitas',
            style: AppTypography.body2.copyWith(fontWeight: AppTypography.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Jam Fokus',
                  '${lifestyle['study_hours_per_day'] ?? 0}',
                  'jam',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatItem(
                  'Olahraga',
                  '${lifestyle['exercise_minute'] ?? 0}',
                  'mnt',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatItem(
                  'Sosial',
                  '${lifestyle['breaks_per_day'] ?? 0}',
                  'jam',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Kesehatan',
            style: AppTypography.body2.copyWith(fontWeight: AppTypography.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Jam Tidur',
                  '${lifestyle['sleep_hours'] ?? 0}',
                  'jam',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatItem(
                  'Kafein',
                  '${lifestyle['coffee_intake_mg'] ?? 0}',
                  'ml',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.lav50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.body2.copyWith(
              color: AppColors.lav900,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTypography.h6.copyWith(
                  color: AppColors.dark,
                  fontSize: 18,
                  fontWeight: AppTypography.bold,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: AppTypography.body2.copyWith(
                  color: AppColors.dark,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mint200,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
                (route) => false, // false artinya hapus semua route sebelumnya
              );
            },
            child: Text(
              'Kembali ke beranda',
              style: AppTypography.h6.copyWith(
                color: AppColors.mint900,
                fontWeight: AppTypography.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.mint900, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const MainPage(initialIndex: 2), // 2 = Tab History
                ),
                (route) => false,
              );
            },
            child: Text(
              'Lihat History',
              style: AppTypography.h6.copyWith(
                color: AppColors.mint900,
                fontWeight: AppTypography.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
    const int maxLength = 100;
    final String fullText = widget.text;

    if (fullText.length <= maxLength) {
      return Text(
        '“$fullText”',
        style: AppTypography.body2.copyWith(color: AppColors.dark),
      );
    }

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
              style: AppTypography.body2.copyWith(color: AppColors.dark),
            ),
            TextSpan(
              text: isExpanded
                  ? 'Tampilkan Lebih Sedikit'
                  : 'Lihat Selengkapnya',
              style: AppTypography.body2.copyWith(
                color: Colors.grey[600],
                decoration: TextDecoration.underline,
                fontWeight: AppTypography.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
