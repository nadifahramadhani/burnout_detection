

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/burnout_bar_chart.dart';
import '../../../core/widgets/journal_card.dart';
import '../providers/history_provider.dart';
import '../../journaling/models/detection_result_model.dart';
import '../../journaling/presentation/detection_result_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  int _selectedMonth = DateTime.now().month;
  final int _currentYear = DateTime.now().year;

  final List<String> _months = [
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      context.read<HistoryProvider>().fetchWeeklyHistory();
    });
  }

  List<dynamic> _getFilteredHistory(List<dynamic> fullHistory) {
    if (fullHistory.isEmpty) return [];

    return fullHistory.where((item) {
      final dateStr = item['tanggal'] ?? item['created_at'];
      if (dateStr == null) return false;
      try {
        final date = DateTime.parse(dateStr);
        return date.month == _selectedMonth && date.year == _currentYear;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = context.watch<HistoryProvider>();
    final fullHistory = historyProvider.historyList;
    final filteredHistory = _getFilteredHistory(fullHistory);

    return Scaffold(
      backgroundColor: AppColors.secondaryLight,
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            backgroundColor: AppColors.mint900,
            expandedHeight: 120,
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
                padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Riwayat Jurnaling Kamu',
                      style: AppTypography.h6.copyWith(
                        color: Colors.white,
                        fontWeight: AppTypography.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pantau terus perkembangan kesehatan mentalmu',
                      style: AppTypography.body2.copyWith(
                        color: Colors.white.withOpacity(0.8),
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

                  _buildMonthFilter(),
                  const SizedBox(height: 16),

                  _buildChartSection(
                    historyProvider.isLoading,
                    filteredHistory,
                  ),
                  const SizedBox(height: 16),

                  _buildHistoryListSection(
                    historyProvider.isLoading,
                    filteredHistory,
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthFilter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.mint50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_month,
                  color: AppColors.mint900,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Bulan',
                style: AppTypography.h6.copyWith(
                  color: AppColors.dark,
                  fontSize: 16,
                  fontWeight: AppTypography.bold,
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.mint50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _selectedMonth,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.mint900,
                ),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
                style: AppTypography.body2.copyWith(
                  color: AppColors.dark,
                  fontWeight: AppTypography.bold,
                ),
                items: List.generate(12, (index) {
                  return DropdownMenuItem(
                    value: index + 1,
                    child: Text('${_months[index]} $_currentYear'),
                  );
                }),
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedMonth = newValue;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection(bool isLoading, List<dynamic> filteredData) {

    List<String> dates = [];
    List<double> scores = [];

    if (filteredData.isNotEmpty) {

      final chartList = filteredData.take(7).toList().reversed.toList();
      for (var item in chartList) {
        dates.add(_formatDateToDayMonth(item['tanggal'] ?? item['created_at']));
        scores.add(double.tryParse(item['burnout_score'].toString()) ?? 0.0);
      }
    } else {

      dates = [
        '1/$_selectedMonth',
        '5/$_selectedMonth',
        '10/$_selectedMonth',
        '15/$_selectedMonth',
      ];
      scores = [0, 0, 0, 0];
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

              child: BurnoutBarChart(dates: dates, scores: scores),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryListSection(bool isLoading, List<dynamic> filteredData) {
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

          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: AppColors.mint900),
              ),
            )
          else if (filteredData.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Tidak ada riwayat jurnal di bulan ${_months[_selectedMonth - 1]} $_currentYear.",
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];

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

                      final mappedData = {
                        "journal": {
                          "text_jurnal": curhatan,
                          "mood": item['mood'] ?? '-',
                        },
                        "hasil_deteksi": {
                          "burnout_level": level,
                          "burnout_score": skor,

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

                      final resultModel = DetectionResultModel.fromJson(
                        mappedData,
                      );

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

  String _formatDateToDayMonth(String? dateStr) {
    if (dateStr == null) return '';
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
      final bulanStr =
          _months[date.month - 1];
      return '$hari, ${date.day} $bulanStr ${date.year.toString()}';
    } catch (e) {
      return dateStr.split('T')[0];
    }
  }
}
