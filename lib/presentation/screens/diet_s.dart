import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
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
      body: Column(
        children: [
          TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            eventLoader: (day) {
              return dietController.diets.where((diet) =>
                  isSameDay(diet.foodDate, day)
              ).toList();
            },
          )
        ],
      )
    );
  }
}