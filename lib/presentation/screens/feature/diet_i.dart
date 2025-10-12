import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mydiet/domain/common_code.dart';
import 'package:mydiet/domain/diet.dart';
import 'package:mydiet/domain/mois.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/common_c.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/controller/const_c.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/controller/mois_c.dart';
import 'package:mydiet/presentation/screens/feature/diet_info_i.dart';
import 'package:mydiet/presentation/utils/format.dart';
import 'package:mydiet/presentation/widget/chips/chip.dart';
import 'package:mydiet/presentation/widget/input/bottom_picker.dart';
import 'package:mydiet/presentation/widget/painter/cup_painter.dart';
import 'package:mydiet/presentation/widget/toast/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final ConstController constController = Get.put(ConstController());

  // 수분 선언
  final MoisController moisController = Get.put(MoisController());

  // 공통 코드 조회
  final CommonCodeController types = Get.put(CommonCodeController(), tag: 'types');
  final CommonCodeController foodKind = Get.put(CommonCodeController(), tag: 'foodKind');
  final CommonCodeController foodAmount = Get.put(CommonCodeController(), tag: 'foodAmount');

  // id가 있으면 기존 diet의 selectedDate로 조회
  // id가 없으면 date_controller의 selectedDate로 조회
  final TextEditingController textEditingController = TextEditingController();

  late SharedPreferences prefs;

  int tagKind = 1;

  @override
  void initState() {
    super.initState();

    initPrefs();

    id = (Get.arguments ?? 0) as int;

    if (id != 0) {
      diets = Get.put(DietController(id));
      diets.dietById(id).then((_) {
        textEditingController.text = Format().formatDateTime(diets.selectedDate.value);
      });
    } else {
      diets = Get.put(DietController(0));

      textEditingController.text = Format().formatDateTime(constController.selectedDate.value);
    }

    // 날짜 변경 감지
    ever(constController.selectedDate, (DateTime date) {
      textEditingController.text = Format().formatDateTime(date);

      // 선택한 날짜를 diets에도 반영
      diets.selectedDate.value = date;
    });

    types.fetchCommon("TYPE");
    foodKind.fetchCommon('FOOD_KIND');
    foodAmount.fetchCommon('FOOD_AMOUNT');
  }
  int tagAmount = 1;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<DietController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back),
        actions: [
          Obx(() {
            // TYPE_DIET일 때
            if (constController.types.value == 'TYPE_DIET') {
              return GestureDetector(
                onTap: () {
                  if (id != 0) {
                    final diet = Diet(
                      id: id,
                      userId: prefs.getString("uuid"),
                      foodType: '식단',
                      foodKind: foodKind.commons[tagKind].name,
                      foodAmount: foodAmount.commons[tagAmount].name,
                      foodDate: diets.selectedDate.value,
                      foodList: diets.foods.toList(),
                      isFavorite: false
                    );

                    SetToast().bar(context, "식단이 수정되었습니다!");
                    diets.edit(diet);
                  } else {
                    final diet = Diet(
                      userId: prefs.getString("uuid"),
                      foodType: '식단',
                      foodKind: foodKind.commons[tagKind].name,
                      foodAmount: foodAmount.commons[tagAmount].name,
                      foodDate: diets.selectedDate.value,
                      foodList: diets.foods.toList(),
                      isFavorite: false
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
            // TYPE_WATER일 때
            else if (constController.types.value == 'TYPE_WATER') {
              return GestureDetector(
                onTap: () {
                  var now = DateTime.now();

                  final mois = Mois(
                      amountMois: moisController.currentWater.value,
                      moisDate: now
                  );

                  moisController.insert(mois);

                  SetToast().bar(context, "수분이 등록되었습니다!");
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Text(
                    '등록',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
            // 기본값 (버튼 없음)
            else {
              return const SizedBox.shrink();
            }
          })
        ],
      ),

      body: Obx(() {

        // 칼로리 계산
        final sumKcal = diets.foods.fold(0.0, (sum, item) => sum += item.energyKcal);

        final widget = switch (constController.types.value) {
          'TYPE_DIET' => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0, left: 12.0),
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
                    onTap: () => BottomPickers().showDatePicker(context, constController),
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

              SizedBox(
                height: 230,
                child: Obx(() {
                  return ListView.builder(
                    itemCount: diets.foods.length,
                    itemBuilder: (context, index) {
                      final food = diets.foods[index];

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
                  );
                }),
              ),
            ],
          ),

          'TYPE_WATER' => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                double waterLevel = (moisController.currentWater.value / constController.dailyGoal.value).clamp(0.0, 1.0);

                return Center(
                  child: CustomPaint(
                    size: const Size(300, 300),
                    painter: CupPainter(
                      waterLevel: waterLevel,
                      repaint: moisController.currentWaterNotifier
                    ),
                  ),
                );
              }),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  GestureDetector(
                    onTap: () {
                      moisController.onSelected(500);
                    },
                    child: SizedBox(
                      width: 80,
                      height: 40,

                      child: Card(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                              '+ 500ML'
                          ),
                        )
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 6,
                  ),

                  GestureDetector(
                    onTap: () {
                      moisController.onSelected(100);
                    },
                    child: SizedBox(
                      width: 80,
                      height: 40,

                      child: Card(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                              '+ 100ML'
                          ),
                        )
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 6,
                  ),

                  GestureDetector(
                    onTap: () {
                      moisController.onSelected(-500);
                    },
                    child: SizedBox(
                      width: 80,
                      height: 40,

                      child: Card(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                              '- 500ML'
                          ),
                        )
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 6,
                  ),

                  GestureDetector(
                    onTap: () {
                      moisController.onSelected(-100);
                    },
                    child: SizedBox(
                      width: 80,
                      height: 40,

                      child: Card(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                              '- 100ML'
                          ),
                        )
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          _ => SizedBox.shrink(),
        };

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
                  '종류를 선택해주세요!',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                    'Select Item',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: types.commons.map((CommonCode item) {
                      return DropdownMenuItem<String>(
                        value: item.code, // 실제 선택값
                        child: Text(
                          item.name, // 화면에 보여줄 이름
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    value: types.commons.any((item) => item.code == constController.types.value)
                            ? constController.types.value
                            : null,
                    onChanged: (String? value) {
                      setState(() {
                        constController.onSelected(value!);
                      });
                    },
                  )
                ),
              ),

              widget,
            ],
          );
        }
      }),
    );
  }
}