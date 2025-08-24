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
        padding: const EdgeInsets.all(16.0),
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
            
            Obx(() {
              final diets = dietController.diets
                .where((diet) => isSameDay(diet.foodDate, dietController.selectedDate.value)).toList();

              return Column(
                children: diets.map((diet) {
                  // foodType별 색상 지정
                  Color typeColor;
                  switch (diet.foodType) {
                    case '식단':
                      typeColor = Const().buildColors()[0];
                      break;
                    default:
                      typeColor = Colors.grey;
                  }

                  final sumKcal = diet.foodList.fold(0.0, (sum, item) => sum += item.energyKcal);

                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: typeColor,
                            shape: BoxShape.circle,
                          ),
                        ),

                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: diet.foodList.map((food) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                      food.foodName
                                  ),
                                );
                              }).toList()
                            ),
                            Text(
                                '${sumKcal}kcal'
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            })
          ],
        ),
      )
    );
  }
}