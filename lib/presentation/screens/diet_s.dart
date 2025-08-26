import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/widget/builder/builder.dart';
import 'package:mydiet/presentation/widget/item/item.dart';
import 'package:table_calendar/table_calendar.dart';

class DietS extends StatefulWidget {
  const DietS({super.key});

  @override
  State<DietS> createState() => _DietSState();
}

class _DietSState extends State<DietS> with TickerProviderStateMixin {
  final DietController dietController = Get.put(DietController());

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    dietController.fetchDiet();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: TableCalendar(
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
              ),
            );
          }),

          TabBar.secondary(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(text: '식단'),
              Tab(text: '운동'),
              Tab(text: '간식'),
            ],
          ),

          // 식단 리스트 (스크롤 가능)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Obx(() {
                  final diets = dietController.diets
                      .where((diet) =>
                      isSameDay(diet.foodDate, dietController.selectedDate.value))
                      .toList();

                  return Item(
                    data: diets,
                  );
                }),
                Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Center(child: Text('Specifications tab')),
                ),
                Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Center(child: Text('Specifications tab')),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}