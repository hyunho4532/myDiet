import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mydiet/domain/recent_week_height.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/widget/text.dart';

class HeightLineChart extends StatelessWidget {
  const HeightLineChart({
    super.key,
    required this.isShowingMainData,
    required this.data
  });

  final bool isShowingMainData;
  final RxList<RecentWeekHeight> data;

  @override
  Widget build(BuildContext context) {
    return Obx(() => LineChart(
        sampleData1,
        duration: const Duration(milliseconds: 250),
      ),
    );
  }

  LineChartData get sampleData1 {
    final weights = data.map((e) => e.weight).toList();
    final minWeight = weights.isEmpty ? 0 : weights.reduce((a, b) => a < b ? a : b);
    final maxWeight = weights.isEmpty ? 0 : weights.reduce((a, b) => a > b ? a : b);

    return LineChartData(
      lineTouchData: lineTouchData1,
      gridData: gridData,
      titlesData: titlesData1,
      borderData: borderData,
      lineBarsData: lineBarsData1,
      minX: 0,
      maxX: (data.length - 1).toDouble(),
      minY: minWeight - 1,
      maxY: maxWeight + 1,
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      getTooltipColor: (touchedSpot) =>
          Colors.blueGrey.withValues(alpha: 0.8),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1
  ];

  LineTouchData get lineTouchData2 => const LineTouchData(
    enabled: false,
  );

  FlTitlesData get titlesData2 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text = switch (value.toInt()) {
      1 => '0',
      2 => '75',
      3 => '150',
      _ => '',
    };
    return SideTitleWidget(
      meta: meta,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    final index = value.toInt();

    if (index < 0 || index >= data.length) {
      return const SizedBox.shrink();
    }

    final date = data[index].foodDate;
    final formattedDate = "${date.day}일";

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: CustomText(
        message: formattedDate,
        fontSize: 16,
        fontFamily: 'PyeojinGothicMedium',
        color: Colors.grey,
      ),
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(
          color: AppColors.primary.withValues(alpha: 0.2), width: 4),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    color: AppColors.contentColorGreen,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: List.generate(
      data.length,
          (index) {
        final item = data[index];

        // 소수점 한자리 기준으로 계산
        final roundedWeight = double.parse(item.weight.toStringAsFixed(2));

        return FlSpot(index.toDouble(), roundedWeight);
      },
    ),
  );
}