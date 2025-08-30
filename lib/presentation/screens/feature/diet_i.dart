import 'package:flutter/material.dart';
import 'package:mydiet/domain/diet.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/common_c.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/controller/date_c.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/screens/feature/diet_info_i.dart';
import 'package:mydiet/presentation/widget/chips/chip.dart';
import 'package:mydiet/presentation/widget/input/bottom_picker.dart';
import 'package:mydiet/presentation/widget/toast/snack_bar.dart';

class DietI extends StatefulWidget {
  const DietI({super.key});

  @override
  State<DietI> createState() => _DietIState();
}

class _DietIState extends State<DietI> {

  late final int id;

  // diets 선언
  late final DietController diets;

  // 홈에서 TableCalendar 클릭 시, 날짜 조회
  final DateController dateController = Get.put(DateController());

  // 공통 코드 조회
  final CommonCodeController foodKind = Get.put(CommonCodeController(), tag: 'foodKind');
  final CommonCodeController foodAmount = Get.put(CommonCodeController(), tag: 'foodAmount');

  // id가 있으면 기존 diet의 selectedDate로 조회
  // id가 없으면 date_controller의 selectedDate로 조회
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    print("Diet I");

    id = (Get.arguments ?? 0) as int;

    if (id != 0) {
      diets = Get.put(DietController(id));
      diets.dietById(id).then((_) {
        textEditingController.text =
        "${diets.selectedDate.value.month}월 ${diets.selectedDate.value.day}일 "
            "${diets.selectedDate.value.hour.toString().padLeft(2, "0")}시 "
            "${diets.selectedDate.value.minute.toString().padLeft(2, "0")}분";
      });
    } else {
      diets = Get.put(DietController(0));

      textEditingController.text =
      "${dateController.selectedDate.value.month}월 ${dateController.selectedDate.value.day}일 "
          "${dateController.selectedDate.value.hour.toString().padLeft(2, "0")}시 "
          "${dateController.selectedDate.value.minute.toString().padLeft(2, "0")}분";

      Get.delete<DietController>();
    }

    foodKind.fetchCommon('FOOD_KIND');
    foodAmount.fetchCommon('FOOD_AMOUNT');
  }

  int tagKind = 1;
  int tagAmount = 1;

  @override
  void dispose() {
    super.dispose();
    diets.fetchDiet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back),
        actions: [
          GestureDetector(
            onTap: () {
              if (id != 0) {
                final diet = Diet(
                  id: id,
                  foodType: '식단',
                  foodKind: foodKind.commons[tagKind].name,
                  foodAmount: foodAmount.commons[tagAmount].name,
                  foodDate: diets.selectedDate.value,
                  foodList: diets.foods.toList()
                );

                SetToast().bar(context, "식단이 수정되었습니다!");

                diets.edit(diet);
              } else {
                final diet = Diet(
                    foodType: '식단',
                    foodKind: foodKind.commons[tagKind].name,
                    foodAmount: foodAmount.commons[tagAmount].name,
                    foodDate: diets.selectedDate.value,
                    foodList: diets.foods.toList()
                );

                SetToast().bar(context, "식단이 등록되었습니다!");

                diets.insert(diet);
              }

              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                 id != 0 ? '수정' : '기록',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),

      body: Obx(() {
        final foods = diets.foods;

        // 칼로리 계산
        final sumKcal = foods.fold(0.0, (sum, item) => sum += item.energyKcal);

        if (foodKind.commons.isEmpty && foodAmount.commons.isEmpty) {
          return Center(
            child: Text(
              '데이터를 불러오고 있습니다.'
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  '오늘은 어떤 식사를 하셨나요?',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                child: Text(
                  '식사 종류는 어떻게 되시나요?',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ),

              Chips(
                type: 'FOOD_KIND',
                tags: tagKind,
                data: foodKind.commons,
                onChanged: (val) {
                    setState(() {
                      tagKind = val;
                    });
                },
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                child: Text(
                  '식사량이 어떻게 되셨나요?',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),

              Chips(
                type: 'FOOD_AMOUNT',
                tags: tagAmount,
                data: foodAmount.commons,
                onChanged: (val) {
                  setState(() {
                    tagAmount = val;
                  });
                },
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                child: Text(
                  '언제 식사를 하셨나요?',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                child: SizedBox(
                  width: 240,
                  height: 60,
                  child: TextField(
                    controller: textEditingController,
                    readOnly: true, // 키보드 안 뜨게
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      labelText: "섭취 시간",
                      labelStyle: TextStyle(
                        color: Const().buildColors()[0],
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: Icon(Icons.fastfood_sharp, color: Const().buildColors()[0]),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onTap: () => BottomPickers().showDatePicker(context, diets),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        '식단을 등록해주세요',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 8), // 간격

                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Const().buildColors()[0],
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.add, color: Colors.white, size: 24),
                        onPressed: () {
                          Get.to(DietInfoI());
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  children: [
                    Text(
                      '총 칼로리: $sumKcal kcal',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),

              Expanded(
                child: Obx(() {
                  return SizedBox(
                    height: 40,
                    child: ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        final food = foods[index];

                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(food.foodName),
                              GestureDetector(
                                onTap: () {
                                  diets.deleteFoodList(index, food);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Const().buildColors()[2],
                                ),
                              )
                            ],
                          ),
                          subtitle: Text("${food.energyKcal} kcal"),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          );
        }
      }),
    );
  }
}