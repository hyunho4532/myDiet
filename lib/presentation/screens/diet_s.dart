import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/utils/builder.dart';
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
            TableCalendar(
              locale: 'ko_KR',
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  // 해당 날짜에 Diet가 있는지 확인
                  final dayDiets = dietController.diets.where(
                          (diet) => isSameDay(diet.foodDate, day)
                  ).toList();

                  if (dayDiets.isEmpty) return SizedBox(); // 없으면 표시 안함

                  // 점 여러 개 표시 (diet 개수만큼)
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: dayDiets.map((diet) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 1),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.blue, // 점 색상
                          shape: BoxShape.circle,
                        ),
                      );
                    }).toList(),
                  );
                },
                dowBuilder: (context, day) => buildDow(context, day),
              )
            )
          ],
        ),
      )
    );
  }
}