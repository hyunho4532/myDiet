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

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
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
                          title: Card(
                            elevation: 0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          dietMessages,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          "${diet.foodDate.hour}시 ${diet.foodDate.minute}분",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  for (int i = 0; i < diet.foodList.length; i += 3)
                                    Row(
                                      children: [
                                        for (int j = i; j < i + 3 && j < diet.foodList.length; j++)
                                          Container(
                                            constraints: BoxConstraints(
                                                minWidth: 100,
                                                minHeight: 60
                                            ),
                                            child: Card(
                                              color: Const().buildColors()[2],
                                              child: Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      diet.foodList[j].foodName,
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),
                                                    ),

                                                    Text(
                                                      "${diet.foodList[j].energyKcal} kcal",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          )
                      );
                    },
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