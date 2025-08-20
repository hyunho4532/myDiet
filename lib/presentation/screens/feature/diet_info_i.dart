import 'package:flutter/material.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/controller/food_c.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/widget/row/row.dart';

class DietInfoI extends StatefulWidget {
  const DietInfoI({super.key});

  @override
  State<DietInfoI> createState() => _DietInfoIState();
}

class _DietInfoIState extends State<DietInfoI> {
  final TextEditingController _searchController = TextEditingController();
  final FoodController foodController = Get.put(FoodController());
  final DietController dietController = Get.put(DietController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              '식단 기록',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '원하시는 음식을 검색하세요.',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    )
                  ),
                ),

                const SizedBox(width: 8),

                ElevatedButton(
                  onPressed: () {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      foodController.fetchFood(query); // 🔥 Controller 호출
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Const().buildColors()[0], // 버튼 색
                    foregroundColor: Colors.white, // 아이콘 색
                    elevation: 2, // 살짝 그림자
                  ),
                  child: const Icon(Icons.search, size: 24),
                )
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (foodController.foods.isEmpty) {
                return Center(
                  child: Text(
                    '검색 결과가 없습니다',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                );
              }

              return ListView.builder(
                itemCount: foodController.foods.length,
                itemBuilder: (context, index) {
                  final food = foodController.foods[index];
                  return ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(food.foodName),
                            GestureDetector(
                              onTap: () {
                                dietController.setFoodList(index, food);
                              },
                              child: Icon(
                                Icons.check,
                                color: Const().buildColors()[0],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "${food.energyKcal}kcal",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                          ),
                        ),

                        /**
                         * 영양 성분 공개
                         */
                        Column(
                          children: [
                            DietInfoRow(text: '수분(g)', data: food.waterG),
                            DietInfoRow(text: '단백질(g)', data: food.proteinG),
                            DietInfoRow(text: '지방(g)', data: food.fatG),
                            DietInfoRow(text: '탄수화물(g)', data: food.carbohydrateG),
                            DietInfoRow(text: '당류(g)', data: food.sugarsG)
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Divider(
                            height: 1,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
