// lib/features/journal/presentation/journaling_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/journal_provider.dart';
import '../../history/providers/history_provider.dart';

import 'detection_result_page.dart';

class JournalingPage extends StatefulWidget {
  const JournalingPage({super.key});

  @override
  State<JournalingPage> createState() => _JournalingPageState();
}

class _JournalingPageState extends State<JournalingPage> {
  int _selectedTabIndex = 0;
  String _selectedMood = '';

  double _jamFokus = 0;
  int _olahraga = 0;
  double _sosial = 0;
  double _jamTidur = 0;
  int _kafein = 0;
  final TextEditingController _jurnalController = TextEditingController();

  Future<void> _onDeteksiDitekan() async {
    if (_jurnalController.text.trim().isEmpty || _selectedMood.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jurnal dan mood wajib diisi!')),
      );
      return;
    }

    final provider = context.read<JournalProvider>();

    final isSuccess = await provider.detectBurnout(
      textJurnal: _jurnalController.text.trim(),
      mood: _selectedMood,
      studyHours: _jamFokus,
      sleepHours: _jamTidur,
      exerciseMinute: _olahraga,
      breaksPerDay: _sosial.toInt(),
      coffeeIntake: _kafein,
    );
    if (isSuccess && mounted) {
      // --- TAMBAHAN KODE: Minta provider tarik data terbaru dari database ---
      context.read<JournalProvider>().fetchJournals();
      context.read<HistoryProvider>().fetchWeeklyHistory();
      // ----------------------------------------------------------------------

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetectionResultPage(resultData: provider.resultData!),
        ),
      );
    } else if (!isSuccess && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(provider.errorMessage ?? 'Gagal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.watch<JournalProvider>().isLoading;

    return Scaffold(
      backgroundColor: AppColors.secondaryLight,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  if (_selectedTabIndex == 0) _buildRefleksiDiriContent(),
                  if (_selectedTabIndex == 1) _buildPolaHidupContent(isLoading),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 0),
      decoration: const BoxDecoration(
        color: AppColors.mint900,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: _buildTabItem('Refleksi Diri', 0)),
          const SizedBox(width: 16),
          Expanded(child: _buildTabItem('Pola Hidup', 1)),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isActive = _selectedTabIndex == index;
    Color indicatorColor = isActive ? AppColors.mint400 : AppColors.mint50;
    Color textColor = isActive ? Colors.white : Colors.white.withOpacity(0.7);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTypography.body2.copyWith(
              color: textColor,
              fontWeight: AppTypography.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: indicatorColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefleksiDiriContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                'Tulis Refleksi Hari Ini',
                style: AppTypography.h6.copyWith(
                  color: AppColors.mint900,
                  fontWeight: AppTypography.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ceritakan apa saja yang terjadi hari ini.',
                style: AppTypography.body2.copyWith(
                  color: AppColors.dark,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
                'Apa yang kamu rasakan hari ini ?',
                style: AppTypography.h6.copyWith(
                  color: AppColors.dark,
                  fontSize: 16,
                  fontWeight: AppTypography.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _jurnalController,
                maxLines: 8,
                style: AppTypography.body2.copyWith(color: AppColors.dark),
                decoration: InputDecoration(
                  hintText: 'Tuliskan perasaanmu di sini...',
                  hintStyle: AppTypography.body2.copyWith(color: Colors.grey),
                  contentPadding: const EdgeInsets.all(16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.mint600,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildSelectableMood(
                      'Senang',
                      const Color(0xFFCAE894),
                    ),
                  ),
                  Expanded(
                    child: _buildSelectableMood(
                      'Biasa Aja',
                      const Color(0xFFF5D87A),
                    ),
                  ),
                  Expanded(
                    child: _buildSelectableMood(
                      'Sedih',
                      const Color(0xFFEA6567),
                    ),
                  ),
                  Expanded(
                    child: _buildSelectableMood(
                      'Marah',
                      const Color(0xFFD14040),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
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
                  onPressed: () => setState(() => _selectedTabIndex = 1),
                  child: Text(
                    'Lanjut',
                    style: AppTypography.h6.copyWith(
                      color: AppColors.mint900,
                      fontWeight: AppTypography.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectableMood(String label, Color color) {
    bool isSelected = _selectedMood == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedMood = label),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: AppColors.mint900, width: 3)
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.body2.copyWith(
              color: AppColors.dark,
              fontSize: 11,
              fontWeight: isSelected ? AppTypography.bold : FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPolaHidupContent(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                'Aktivitas Kamu Hari Ini',
                style: AppTypography.h6.copyWith(
                  color: AppColors.mint900,
                  fontWeight: AppTypography.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Catat kebiasaan harianmu agar kami bisa menganalisisnya.',
                style: AppTypography.body2.copyWith(
                  color: AppColors.dark,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
                'Produktifitas',
                style: AppTypography.h6.copyWith(
                  color: AppColors.dark,
                  fontWeight: AppTypography.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              // --- TAMBAHAN DESKRIPSI DI SINI ---
              _buildSliderItem(
                label: 'Jam Fokus',
                description: 'Lama waktu kamu belajar atau bekerja',
                value: _jamFokus,
                unit: 'jm',
                min: 0,
                max: 15,
                onChanged: (val) => setState(() => _jamFokus = val),
              ),
              const SizedBox(height: 20),
              _buildCounterItem(
                label: 'Olahraga',
                description: 'Total menit kamu berolahraga hari ini',
                value: _olahraga,
                unit: 'mnt',
                step: 5,
                onMinus: () => setState(() {
                  if (_olahraga > 0) _olahraga -= 5;
                }),
                onPlus: () => setState(() => _olahraga += 5),
              ),
              const SizedBox(height: 20),
              _buildSliderItem(
                label: 'Sosial',
                description:
                    'Waktu yang dihabiskan berinteraksi dengan orang lain',
                value: _sosial,
                unit: 'jm',
                min: 0,
                max: 15,
                onChanged: (val) => setState(() => _sosial = val),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
                'Kesehatan',
                style: AppTypography.h6.copyWith(
                  color: AppColors.dark,
                  fontWeight: AppTypography.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              _buildSliderItem(
                label: 'Jam Tidur',
                description: 'Durasi tidurmu tadi malam',
                value: _jamTidur,
                unit: 'jm',
                min: 0,
                max: 15,
                onChanged: (val) => setState(() => _jamTidur = val),
              ),
              const SizedBox(height: 20),
              _buildCounterItem(
                label: 'Kafein',
                description: 'Perkiraan konsumsi kopi/kafein (dalam mg)',
                value: _kafein,
                unit: 'mg', // Sedikit perbaikan unit dari 'ml' ke 'mg'
                step: 10,
                onMinus: () => setState(() {
                  if (_kafein > 0) _kafein -= 10;
                }),
                onPlus: () => setState(() => _kafein += 10),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
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
            onPressed: isLoading ? null : _onDeteksiDitekan,
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: AppColors.mint900),
                  )
                : Text(
                    'Deteksi',
                    style: AppTypography.h6.copyWith(
                      color: AppColors.mint900,
                      fontWeight: AppTypography.bold,
                      fontSize: 18,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  // HELPER: SLIDER ITEM
  Widget _buildSliderItem({
    required String label,
    required String description, // Tambahan parameter
    required double value,
    required String unit,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    List<TextSpan> spans = [];
    int hours = value.toInt();
    int minutes = ((value - hours) * 60).round();

    spans.add(
      TextSpan(
        text: '$hours',
        style: const TextStyle(
          color: AppColors.dark,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    spans.add(
      const TextSpan(
        text: ' jm',
        style: TextStyle(color: AppColors.lav600, fontSize: 10),
      ),
    );

    if (minutes > 0) {
      spans.add(const TextSpan(text: ' '));
      spans.add(
        TextSpan(
          text: '$minutes',
          style: const TextStyle(
            color: AppColors.dark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      spans.add(
        const TextSpan(
          text: ' mnt',
          style: TextStyle(color: AppColors.lav600, fontSize: 10),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment
              .start, // Agar sejajar atas jika deskripsi panjang
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.body2.copyWith(
                      color: AppColors.dark,
                      fontWeight: AppTypography.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTypography.body2.copyWith(
                      color: Colors
                          .grey[600], // Warna deskripsi agar terlihat seperti sub-label
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text.rich(TextSpan(children: spans)),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 6,
            activeTrackColor: AppColors.lav50,
            inactiveTrackColor: AppColors.lav50,
            thumbColor: AppColors.mint900,
            overlayColor: AppColors.mint900.withOpacity(0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) * 2).toInt(),
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${min.toInt()}$unit',
                style: const TextStyle(color: AppColors.lav400, fontSize: 12),
              ),
              Text(
                '${max.toInt()}$unit',
                style: const TextStyle(color: AppColors.lav400, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // HELPER: COUNTER ITEM
  Widget _buildCounterItem({
    required String label,
    required String description, // Tambahan parameter
    required int value,
    required String unit,
    required int step,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    List<TextSpan> spans = [];

    if (unit == 'mnt' && value >= 60) {
      int hours = value ~/ 60;
      int mins = value % 60;

      spans.add(
        TextSpan(
          text: '$hours',
          style: const TextStyle(
            color: AppColors.dark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      spans.add(
        const TextSpan(
          text: ' jm',
          style: TextStyle(color: AppColors.lav600, fontSize: 12),
        ),
      );

      if (mins > 0) {
        spans.add(const TextSpan(text: ' '));
        spans.add(
          TextSpan(
            text: '$mins',
            style: const TextStyle(
              color: AppColors.dark,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        spans.add(
          const TextSpan(
            text: ' mnt',
            style: TextStyle(color: AppColors.lav600, fontSize: 12),
          ),
        );
      }
    } else {
      spans.add(
        TextSpan(
          text: '$value',
          style: const TextStyle(
            color: AppColors.dark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      spans.add(
        TextSpan(
          text: ' $unit',
          style: const TextStyle(color: AppColors.lav600, fontSize: 12),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.body2.copyWith(
                  color: AppColors.dark,
                  fontWeight: AppTypography.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: AppTypography.body2.copyWith(
                  color: Colors
                      .grey[600], // Warna deskripsi agar terlihat seperti sub-label
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            GestureDetector(
              onTap: onMinus,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.mint900, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.remove,
                  color: AppColors.mint900,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 85,
              child: Text.rich(
                TextSpan(children: spans),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: onPlus,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.mint900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
