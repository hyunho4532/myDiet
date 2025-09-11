import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/const_c.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/controller/mois_c.dart';
import 'package:mydiet/presentation/widget/builder/builder.dart';
import 'package:mydiet/presentation/widget/item/item.dart';
import 'package:table_calendar/table_calendar.dart';

class DietS extends StatefulWidget {
  const DietS({super.key});

  @override
  State<DietS> createState() => _DietSState();
}

class _DietSState extends State<DietS> with TickerProviderStateMixin {
  // 식단 관련 controller
  final DietController dietController = Get.put(DietController(0));

  // 수분 관련 controller
  final MoisController moisController = Get.put(MoisController());

  final constController = Get.put(ConstController());

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    dietController.fetchDiet();
    moisController.fetchMois();
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
                  focusedDay: constController.selectedDate.value,
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true
                  ),
                  selectedDayPredicate: (day) => isSameDay(constController.selectedDate.value, day),
                  onDaySelected: (day, _ ) {
                    constController.selectedDate.value = day;
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) => buildMarker(context, day, dietController, moisController),
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
              Tab(text: '수분'),
            ],
            onTap: (value) => {
              setState(() {
                _tabController.index = value;
              })
            },
            indicatorColor: _tabController.index == 0 ? Const().buildColors()[0] : Const().buildColors()[1]
          ),

          // 식단 리스트 (스크롤 가능)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Obx(() {
                  dietController.fetchDiet();

                  final diets = dietController.diets
                      .where((diet) => isSameDay(diet.foodDate, constController.selectedDate.value))
                      .toList();

                  return Item(
                    data: diets,
                  );
                }),

                Obx(() {
                  moisController.fetchMois();

                  final moiss = moisController.moiss
                    .where((mois) => isSameDay(mois.moisDate, constController.selectedDate.value))
                    .toList();

                  return Item(
                    data: moiss,
                  );
                }),

                Obx(() {
                  final moiss = moisController.moiss
                      .where((mois) => isSameDay(mois.moisDate, constController.selectedDate.value))
                      .toList();

                  return Item(
                    data: moiss,
                  );
                }),
              ],
            ),
          ),
        ],
      )
    );
  }
}