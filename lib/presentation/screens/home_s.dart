import 'package:date_field/date_field.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/utils/format.dart';
import 'package:mydiet/presentation/widget/row/row.dart';

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
    dietController.fetchDietDate('week');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            dietController.fetchDietDate('week');
                          },
                          child: Text("최근 7일")
                      ),
                      GestureDetector(
                          onTap: () {
                            dietController.fetchDietDate('month');
                          },
                          child: Text("최근 30일")
                      ),
                      Text("직접 입력")
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: Format().axisAlignment(),
                      children: [
                        SizedBox(
                          width: Format().width(context, mobile: 168, webFactor: 0.4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DateTimeFormField(
                              initialValue: dietController.dietsDate[0].startDate,
                              mode: DateTimeFieldPickerMode.date,
                              dateFormat: DateFormat('yyyy-MM-dd'),
                              decoration: InputDecoration(
                                labelText: '시작일',
                                hintText: '날짜 선택',
                                hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                                prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.blueAccent, width: 1.2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.grey, width: 0),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              onChanged: (DateTime? value) {
                                dietController.dietsDate[0].startDate = value;
                                dietController.fetchDietInfo(
                                  dietController.dietsDate[0].startDate,
                                  dietController.dietsDate[0].endDate,
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          "~",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          ),
                        ),

                        const SizedBox(width: 8),

                        SizedBox(
                          width: Format().width(context, mobile: 168, webFactor: 0.4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DateTimeFormField(
                              initialValue: dietController.dietsDate[0].endDate,
                              mode: DateTimeFieldPickerMode.date,
                              dateFormat: DateFormat('yyyy-MM-dd'),
                              decoration: InputDecoration(
                                labelText: '종료일',
                                hintText: '날짜 선택',
                                hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                                prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.blueAccent, width: 1.2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.grey, width: 0),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              onChanged: (DateTime? value) {
                                dietController.dietsDate[0].endDate = value;
                                dietController.fetchDietInfo(
                                  dietController.dietsDate[0].startDate,
                                  dietController.dietsDate[0].endDate,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: [
                        HomeNutrientRow(label: "단백질", value: "${dietController.nutrient[0].proteinG}"),
                        HomeNutrientRow(label: "탄수화물", value: "${dietController.nutrient[0].carbG}"),
                        HomeNutrientRow(label: "지방", value: "${dietController.nutrient[0].fatG}"),
                        HomeNutrientRow(label: "비타민", value: "${dietController.nutrient[0].vitaminTotal}"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: Card(
                      color: Colors.white,
                      child: SizedBox(
                        width: Format().width(context, mobile: 360, webFactor: 1),
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
                                    HomeDietRow(label: "탄수화물", value: "${dietController.ratios[0].carbPct}%"),
                                    const SizedBox(height: 4),

                                    HomeDietRow(label: "단백질", value: "${dietController.ratios[0].proteinPct}%"),
                                    const SizedBox(height: 4),

                                    HomeDietRow(label: "지방", value: "${dietController.ratios[0].fatPct}%"),
                                    const SizedBox(height: 4),

                                    HomeDietRow(label: "비타민", value: "${dietController.ratios[0].vitaminPct}%"),
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
              ),
            );
          }),
        ]
      ),
    );
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