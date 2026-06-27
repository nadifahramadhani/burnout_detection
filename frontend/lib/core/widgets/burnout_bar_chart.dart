// lib/core/widgets/burnout_bar_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/app_colors.dart';

class BurnoutBarChart extends StatelessWidget {
  final List<String> dates;
  final List<double> scores;

  const BurnoutBarChart({super.key, required this.dates, required this.scores});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        minY: 0,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
            dashArray: [4, 4],
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              reservedSize: 30, // Diberi ruang agar angka tidak terpotong
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30, // Diberi ruang agar tanggal tidak terpotong
              getTitlesWidget: (value, meta) {
                if (value.toInt() < 0 || value.toInt() >= dates.length)
                  return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    dates[value.toInt()],
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: List.generate(
          scores.length,
          (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: scores[index],
                color: _getLavenderShade(
                  scores[index],
                ), // Warna Gradasi Lavender
                width: 16,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLavenderShade(double y) {
    if (y <= 30) return AppColors.lav200; // Lavender terang
    if (y <= 60) return AppColors.lav400; // Lavender medium
    if (y <= 80) return AppColors.lav600; // Lavender tua
    return AppColors.lav900; // Lavender paling pekat
  }
}
