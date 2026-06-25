import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/journal_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _userName = 'Nadifah';
  final String _currentDate = '03 Maret 2026';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.mint900,
            expandedHeight: 130,
            pinned: true,
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentDate,
                          style: AppTypography.body2.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Halo, $_userName!',
                          style: AppTypography.h6.copyWith(
                            color: Colors.white,
                            fontWeight: AppTypography.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Pharetra diam cras',
                          style: AppTypography.body2.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("https://placehold.co/44x44"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMoodPanel(),
                  const SizedBox(height: 16),
                  _buildTrendStatusPanel(),
                  const SizedBox(height: 16),
                  _buildJournalSnippetPanel(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mood Kamu Hari Ini',
            style: AppTypography.h6.copyWith(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: AppTypography.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMoodItem('Senang', const Color(0xFFCAE894)),
              _buildMoodItem('Biasa Aja', const Color(0xFFF5D87A)),
              _buildMoodItem('Sedih', const Color(0xFFEA6567)),
              _buildMoodItem('Marah', const Color(0xFFCAE894)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodItem(String label, Color color) {
    return SizedBox(
      width: 81,
      child: Column(
        children: [
          Container(
            width: 59,
            height: 59,
            decoration: ShapeDecoration(
              color: color,
              shape: const OvalBorder(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.body2.copyWith(
              color: AppColors.dark,
              fontSize: 12,
              fontWeight: AppTypography.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendStatusPanel() {
    final List<String> dates = [
      '28/5',
      '29/5',
      '30/5',
      '31/5',
      '1/6',
      '2/6',
      '3/6',
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tren & Status Terakhir',
            style: AppTypography.h6.copyWith(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: AppTypography.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 144,
            width: double.infinity,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          dates[value.toInt() % dates.length],
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  _makeBarGroup(0, 3.0),
                  _makeBarGroup(1, 5.0),
                  _makeBarGroup(2, 2.5),
                  _makeBarGroup(3, 8.0),
                  _makeBarGroup(4, 4.0),
                  _makeBarGroup(5, 6.0),
                  _makeBarGroup(6, 7.5),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // ... (isi sisa fungsi ini)
        ],
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y) {
    // Logika penentuan warna berdasarkan skor burnout
    Color barColor;
    if (y <= 3) {
      barColor = AppColors.burnoutLow; // Hijau (Skor Rendah)
    } else if (y <= 6) {
      barColor = AppColors.burnoutMedium; // Kuning (Skor Sedang)
    } else if (y <= 8) {
      barColor = AppColors.burnoutHigh; // Orange (Skor Tinggi)
    } else {
      barColor = AppColors.burnoutCritical; // Merah (Skor Kritis)
    }

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor, // Warna berubah otomatis sesuai skor!
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildJournalSnippetPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cuplikan Jurnal',
            style: AppTypography.h6.copyWith(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: AppTypography.bold,
            ),
          ),
          const SizedBox(height: 12),

          // PANGGIL REUSABLE WIDGET 1
          const JournalCard(
            date: 'Sen, 2 Jun 6',
            moodLabel: 'Senang',
            content:
                'In sit amet eget a proin. Viverra nunc tristique nulla quis non dui ipsum mattis nulla. Bibendum turpis dui ut vestibulum turpis parturient suspendisse posuere.',
            statusText: 'Aman & Sehat · 22%',
            statusColor: AppColors.burnoutLow, // Hijau terang
            sleepValue: '10',
            workoutValue: '50',
            focusValue: '8',
            socialValue: '2',
            caffeineValue: '2',
          ),

          const SizedBox(height: 16),

          // PANGGIL REUSABLE WIDGET 2
          const JournalCard(
            date: 'Sen, 2 Jun 6',
            moodLabel: 'Sedih',
            content:
                'In sit amet eget a proin. Viverra nunc tristique nulla quis non dui ipsum mattis nulla. Bibendum turpis dui ut vestibulum turpis parturient suspendisse posuere.',
            statusText: 'Burnout Sedang · 50%',
            statusColor: AppColors.burnoutHigh, // Orange/Merah (Cek figma)
            sleepValue: '10',
            workoutValue: '50',
            focusValue: '8',
            socialValue: '2',
            caffeineValue: '2',
          ),
        ],
      ),
    );
  }
} // <--- JANGAN LUPA KURUNG TUTUP CLASS INI!
