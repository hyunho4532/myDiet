import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mydiet/presentation/const.dart';

// 바 차트 전용 위젯
class NutrientBarChart extends StatelessWidget {
  final double proteinG;
  final double carbG;
  final double fatG;
  final double vitaminTotal;

  const NutrientBarChart({
    super.key,
    required this.proteinG,
    required this.carbG,
    required this.fatG,
    required this.vitaminTotal
  });

  @override
  Widget build(BuildContext context) {
    final nutrientData = [
      {'label': '단백질', 'value': proteinG, 'color': Const().buildChartColor()[1]},
      {'label': '탄수화물', 'value': carbG, 'color': Const().buildChartColor()[0]},
      {'label': '지방', 'value': fatG, 'color': Const().buildChartColor()[2]},
      {'label': '비타민', 'value': vitaminTotal, 'color': Const().buildChartColor()[3]},
    ];

    return AspectRatio(
      aspectRatio: 3,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final index = value.toInt();
                  if (index < 0 || index >= nutrientData.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(nutrientData[index]['label'] as String,
                        style: const TextStyle(fontSize: 12)),
                  );
                },
              ),
            ),
          ),
          barGroups: nutrientData.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data['value'] as double,
                  color: data['color'] as Color,
                  borderRadius: BorderRadius.circular(6),
                  width: 42,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
