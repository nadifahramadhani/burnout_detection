// lib/features/home/presentation/home_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/journal_card.dart';
import '../../../core/widgets/burnout_bar_chart.dart'; // IMPORT WIDGET CHART BARU KITA!

import '../../auth/providers/auth_provider.dart';
import '../../journaling/providers/journal_provider.dart';
import '../../history/providers/history_provider.dart';
import '../../journaling/models/detection_result_model.dart';
import '../../journaling/presentation/detection_result_page.dart';
import '../../profile/providers/profile_provider.dart';
import '../../../core/constants/app_moods.dart';
import '../../../core/widgets/mood_item_widget.dart';
import 'main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // context.read<JournalProvider>().fetchJournals();
      // context.read<HistoryProvider>().fetchWeeklyHistory();
    });
  }

  String _getFormattedDate() {
    final today = DateTime.now();
    const months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${today.day} ${months[today.month]} ${today.year}';
  }

  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final String userName =
        profileProvider.user?.firstName ??
        authProvider.user?.firstName ??
        'Nadifah';
    final String currentDate = _getFormattedDate();

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
                          currentDate,
                          style: AppTypography.body2.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Halo, $userName!',
                          style: AppTypography.h6.copyWith(
                            color: Colors.white,
                            fontWeight: AppTypography.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Pharetra diam cras',
                          style: AppTypography.body2.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // Membuka MainPage dan langsung melompat ke Tab Profil (Indeks 3)
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MainPage(initialIndex: 3),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: AppColors.mint200,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            userName.isNotEmpty
                                ? userName[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              color: AppColors.mint900,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
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
                  _buildTrendStatusPanel(context),
                  const SizedBox(height: 16),
                  _buildJournalSnippetPanel(context),
                  const SizedBox(height: 100),
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
            children: AppMoods.allMoods.map((mood) {
              // Di halaman Home, kita hanya menampilkan (tanpa bisa diklik)
              return MoodItemWidget(mood: mood);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendStatusPanel(BuildContext context) {
    final historyProvider = context.watch<HistoryProvider>();
    final bool isLoading = historyProvider.isLoading;

    List<String> dates = [];
    List<double> chartData = [];

    if (historyProvider.historyList.isNotEmpty) {
      final reversedList = historyProvider.historyList
          .take(7)
          .toList()
          .reversed
          .toList();
      for (var item in reversedList) {
        // PERBAIKAN: Coba ambil dari 'tanggal' dulu, baru 'created_at'
        dates.add(_formatApiDateToShort(item['tanggal'] ?? item['created_at']));

        // PERBAIKAN: Pastikan burnout_score diparsing dengan benar
        double skor = 0.0;
        if (item['burnout_score'] != null) {
          skor = double.tryParse(item['burnout_score'].toString()) ?? 0.0;
        }
        chartData.add(skor);
      }
    } else {
      dates = ['28/5', '29/5', '30/5', '31/5', '1/6', '2/6', '3/6'];
      chartData = [30.0, 50.0, 25.0, 80.0, 40.0, 60.0, 75.0];
    }

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
            'Tren & Status Terakhir',
            style: AppTypography.h6.copyWith(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: AppTypography.bold,
            ),
          ),
          const SizedBox(height: 24),

          if (isLoading)
            const SizedBox(
              height: 180,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.mint900),
              ),
            )
          else
            SizedBox(
              height: 180,
              width: double.infinity,
              // TINGGAL PANGGIL WIDGET YANG BARU KITA BUAT!
              child: BurnoutBarChart(dates: dates, scores: chartData),
            ),
        ],
      ),
    );
  }

  Widget _buildJournalSnippetPanel(BuildContext context) {
    final historyProvider = context.watch<HistoryProvider>();
    final historyList = historyProvider.historyList.take(2).toList();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cuplikan Jurnal',
                style: AppTypography.h6.copyWith(
                  color: AppColors.dark,
                  fontSize: 16,
                  fontWeight: AppTypography.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Lihat Semua',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.mint900,
                    fontWeight: AppTypography.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (historyProvider.isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: AppColors.mint900),
              ),
            )
          else if (historyList.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Kamu belum memiliki jurnal. Yuk catat kondisimu hari ini!",
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final item = historyList[index];

                String curhatan = item['curhatan'] ?? '';
                if (curhatan.isEmpty && item['journal'] != null) {
                  curhatan = item['journal']['text_jurnal'] ?? '';
                }

                double skor =
                    double.tryParse(item['burnout_score']?.toString() ?? '0') ??
                    0.0;
                String level = item['burnout_level'] ?? 'Dianalisis';
                Map<String, dynamic>? lifestyle =
                    item['lifestyle'] ?? item['pola_hidup'];

                Color statusColor = AppColors.burnoutMedium;
                if (skor <= 30)
                  statusColor = AppColors.burnoutLow;
                else if (skor <= 60)
                  statusColor = AppColors.burnoutMedium;
                else if (skor <= 80)
                  statusColor = AppColors.burnoutHigh;
                else
                  statusColor = AppColors.burnoutCritical;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      // 1. Bungkus ulang data API agar sesuai dengan format DetectionResultModel
                      final mappedData = {
                        "journal": {
                          "text_jurnal": curhatan,
                          "mood": item['mood'] ?? '-',
                        },
                        "hasil_deteksi": {
                          "burnout_level": level,
                          "burnout_score": skor,
                          // Handle perbedaan nama key antara API History dan Detection
                          "prob_normal":
                              item['prob_normal'] ??
                              item['probabilitas']?['normal'] ??
                              0.0,
                          "prob_rendah":
                              item['prob_rendah'] ??
                              item['probabilitas']?['rendah'] ??
                              0.0,
                          "prob_sedang":
                              item['prob_sedang'] ??
                              item['probabilitas']?['sedang'] ??
                              0.0,
                          "prob_tinggi":
                              item['prob_tinggi'] ??
                              item['probabilitas']?['tinggi'] ??
                              0.0,
                        },
                        "lifestyle": lifestyle ?? {},
                      };

                      // 2. Ubah menjadi Model
                      final resultModel = DetectionResultModel.fromJson(
                        mappedData,
                      );

                      // 3. Navigasi ke halaman detail
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetectionResultPage(resultData: resultModel),
                        ),
                      );
                    },
                    child: JournalCard(
                      date: _formatApiDateToLong(
                        item['tanggal'] ?? item['created_at'],
                      ),
                      moodLabel: item['mood'] ?? '-',
                      content: curhatan,
                      statusText: '$level · ${skor.toInt()}%',
                      statusColor: statusColor,
                      sleepValue: '${lifestyle?['sleep_hours'] ?? 0}',
                      workoutValue: '${lifestyle?['exercise_minute'] ?? 0}',
                      focusValue: '${lifestyle?['study_hours_per_day'] ?? 0}',
                      socialValue: '${lifestyle?['breaks_per_day'] ?? 0}',
                      caffeineValue: '${lifestyle?['coffee_intake_mg'] ?? 0}',
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  String _formatApiDateToShort(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}';
    } catch (e) {
      return '';
    }
  }

  String _formatApiDateToLong(String? dateStr) {
    if (dateStr == null) return 'Hari ini';
    try {
      final date = DateTime.parse(dateStr);
      final hari = [
        'Min',
        'Sen',
        'Sel',
        'Rab',
        'Kam',
        'Jum',
        'Sab',
      ][date.weekday % 7];
      final bulan = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'Mei',
        'Jun',
        'Jul',
        'Agu',
        'Sep',
        'Okt',
        'Nov',
        'Des',
      ][date.month];
      return '$hari, ${date.day} $bulan ${date.year.toString().substring(2)}';
    } catch (e) {
      return dateStr.split('T')[0];
    }
  }
}
