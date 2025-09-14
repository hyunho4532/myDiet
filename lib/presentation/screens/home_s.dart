import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';

class HomeS extends StatefulWidget {
  const HomeS({super.key});

  @override
  State<HomeS> createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  int touchedIndex = 0;

  // 식단 관련 controller
  final DietController dietController = Get.put(DietController(0));

  @override
  void initState() {
    super.initState();
    dietController.fetchRatio();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: SizedBox(
                height: 140,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: PieChart(
                        PieChartData(
                          startDegreeOffset: -90,
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex =
                                    pieTouchResponse.touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 3,
                          centerSpaceRadius: 20,
                          sections: showingSections(),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "탄수화물",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Const().buildColors()[1]
                                  ),
                                ),

                                Text(
                                  "${dietController.ratios[0].carbPct}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Const().buildColors()[1]
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(height: 4),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "단백질",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Const().buildColors()[1]
                                  ),
                                ),

                                Text(
                                  "${dietController.ratios[0].proteinPct}%",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Const().buildColors()[1]
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(height: 4),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "지방",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Const().buildColors()[1]
                                  ),
                                ),

                                Text(
                                  "${dietController.ratios[0].fatPct}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Const().buildColors()[1]
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(height: 4),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "비타민",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Const().buildColors()[1]
                                  ),
                                ),

                                Text(
                                  "${dietController.ratios[0].vitaminPct}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Const().buildColors()[1]
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 11.0 : 10.0;
      final radius = isTouched ? 50.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Const().buildChartColor()[1],
            value: dietController.ratios[0].proteinPct,
            title: '${dietController.ratios[0].proteinPct}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Const().buildChartColor()[0],
            value: dietController.ratios[0].carbPct,
            title: '${dietController.ratios[0].carbPct}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Const().buildChartColor()[2],
            value: dietController.ratios[0].fatPct,
            title: '${dietController.ratios[0].fatPct}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Const().buildChartColor()[3],
            value: dietController.ratios[0].vitaminPct,
            title: '${dietController.ratios[0].vitaminPct}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}