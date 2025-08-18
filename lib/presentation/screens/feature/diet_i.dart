import 'package:chips_choice/chips_choice.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mydiet/domain/common_code.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/common_c.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/screens/feature/diet_info_i.dart';
import 'package:mydiet/presentation/widget/chips/chip.dart';

class DietI extends StatefulWidget {
  const DietI({super.key});

  @override
  State<DietI> createState() => _DietIState();
}

class _DietIState extends State<DietI> {
  final DietController diets = Get.put(DietController());
  final CommonCodeController foodKind = Get.put(CommonCodeController(), tag: 'foodKind');
  final CommonCodeController foodAmount = Get.put(CommonCodeController(), tag: 'foodAmount');

  @override
  void initState() {
    super.initState();

    foodKind.fetchCommon('FOOD_KIND');
    foodAmount.fetchCommon('FOOD_AMOUNT');
  }

  int tagKind = 1;
  int tagAmount = 1;

  Time _time = Time(hour: 11, minute: 30, second: 20);

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;

      final oldDate = diets.selectedDate.value;
      diets.selectedDate.value = DateTime(
        oldDate.year,
        oldDate.month,
        oldDate.day,
        newTime.hour,
        newTime.minute,
      );
    });
  }

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
               '기록',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),

      body: Obx(() {
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

                      final name = foodKind.commons[val].name;
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

                    final name = foodAmount.commons[val].name;
                  });
                },
              ),

              EasyDateTimeLinePicker(
                locale: Locale('ko'),
                monthYearPickerOptions: MonthYearPickerOptions(
                  confirmTextStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  cancelTextStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                headerOptions: HeaderOptions(
                  headerType: HeaderType.picker,
                ),
                focusedDate: diets.selectedDate.value,
                firstDate: DateTime(2024, 3, 18),
                lastDate: DateTime(2030, 3, 18),
                onDateChange: (date) {
                  setState(() {
                    diets.setFoodDate(date);
                  });
                },
              ),

              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    showPicker(
                      context: context,
                      value: _time,
                      sunrise: TimeOfDay(hour: 6, minute: 0),  // optional
                      sunset: TimeOfDay(hour: 18, minute: 0),  // optional
                      duskSpanInMinutes: 120,                  // optional
                      onChange: onTimeChanged,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(diets.selectedDate.value),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      '⏱ 시간 선택하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
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
              )
            ],
          );
        }
      }),
    );
  }
}