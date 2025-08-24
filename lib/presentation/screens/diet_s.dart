import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  markerBuilder: (context, day, events) => buildMarker(context, day, dietController),
                  dowBuilder: (context, day) => buildDow(context, day),
                )
            ),
            
            Obx(() {
              return Column(
                
              );
            })
          ],
        ),
      )
    );
  }
}