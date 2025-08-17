import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:mydiet/domain/common_code.dart';
import 'package:mydiet/presentation/controller/common_c.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/widget/chips/chip.dart';

class DietI extends StatefulWidget {
  const DietI({super.key});

  @override
  State<DietI> createState() => _DietIState();
}

class _DietIState extends State<DietI> {
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
            ],
          );
        }
      }),
    );
  }
}