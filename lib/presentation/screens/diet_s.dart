import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/widget/builder/builder.dart';
import 'package:table_calendar/table_calendar.dart';

class DietS extends StatefulWidget {
  const DietS({super.key});

  @override
  State<DietS> createState() => _DietSState();
}

class _DietSState extends State<DietS> {
  final DietController dietController = Get.put(DietController());

  @override
  void initState() {
    super.initState();

    dietController.fetchDiet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return TableCalendar(
                  locale: 'ko_KR',
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: dietController.selectedDate.value,
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true
                  ),
                  selectedDayPredicate: (day) => isSameDay(dietController.selectedDate.value, day),
                  onDaySelected: (day, _ ) {
                    dietController.selectedDate.value = day;
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) => buildMarker(context, day, dietController),
                    dowBuilder: (context, day) => buildDow(context, day),
                  )
              );
            }),

            // 식단 리스트 (스크롤 가능)
            Expanded(
              child: Obx(() {
                final diets = dietController.diets
                    .where((diet) =>
                    isSameDay(diet.foodDate, dietController.selectedDate.value))
                    .toList();

                return ListView.builder(
                  itemCount: diets.length,
                  itemBuilder: (context, index) {
                    final diet = diets[index];
                    String dietMessages = "";

                    final sumKcal = diet.foodList.fold(
                      0.0,
                          (sum, item) => sum += item.energyKcal,
                    );

                    if (diet.foodKind == '아침') {
                      if (sumKcal < 400) {
                        dietMessages = "너무 적게 먹었습니다!";
                      } else if (sumKcal >= 400 && sumKcal <= 600) {
                        dietMessages = "적당하게 먹었습니다!";
                      } else {
                        dietMessages = "너무 많이 먹었습니다!";
                      }
                    }

                    if (diet.foodKind == '점심') {
                      if (sumKcal < 500) {
                        dietMessages = "너무 적게 먹었습니다!";
                      } else if (sumKcal >= 560 && sumKcal <= 840) {
                        dietMessages = "적당하게 먹었습니다!";
                      } else {
                        dietMessages = "너무 많이 먹었습니다!";
                      }
                    }

                    if (diet.foodKind == '저녁') {
                      if (sumKcal < 480) {
                        dietMessages = "너무 적게 먹었습니다!";
                      } else if (sumKcal >= 480 && sumKcal <= 720) {
                        dietMessages = "적당하게 먹었습니다!";
                      } else {
                        dietMessages = "너무 많이 먹었습니다!";
                      }
                    }

                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              dietMessages,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey
                              ),
                            ),
                          ),

                          for (int i = 0; i < diet.foodList.length; i += 2)
                            Row(
                              children: [
                                for (int j = i; j < i + 2 && j < diet.foodList.length; j++)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 8, bottom: 4),
                                    child: SizedBox(
                                      height: 80,
                                      child: Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: Column(
                                            children: [
                                              Text(diet.foodList[j].foodName),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                      trailing: Text("${sumKcal.toStringAsFixed(0)} kcal"),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      )
    );
  }
}