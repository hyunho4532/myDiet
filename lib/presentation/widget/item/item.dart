import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mydiet/domain/diet.dart';
import 'package:mydiet/domain/mois.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/const_c.dart';
import 'package:mydiet/presentation/controller/mois_c.dart';
import 'package:mydiet/presentation/screens/feature/diet_i.dart';
import 'package:mydiet/presentation/utils/math.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/widget/painter/cup_painter.dart';
import 'package:mydiet/presentation/widget/responsive/widgets.dart';
import 'package:mydiet/presentation/widget/sizedbox/svg_sizedbox.dart';
import 'package:mydiet/presentation/widget/text.dart';

// Item 위젯 추가
// type에 따라서 state 구분
class Item<T> extends StatefulWidget {
  final List<T> data;

  const Item({
    super.key,
    required this.data,
  });

  @override
  State<Item<T>> createState() {
    if (T == Diet) {
      return _DietItemState() as State<Item<T>>;
    } else {
      return _MoisItemState() as State<Item<T>>;
    }
  }
}

class _DietItemState extends State<Item<Diet>> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        final diet = widget.data[index];
        String dietMessages = "";

        // 합계 계산
        final sumData = Math().sumArray(diet);

        if (diet.foodKind == '아침') {
          if (sumData[0] < 400) {
            dietMessages = "너무 적게 먹었습니다!";
          } else if (sumData[0] >= 400 && sumData[0] <= 600) {
            dietMessages = "적당하게 먹었습니다!";
          } else {
            dietMessages = "너무 많이 먹었습니다!";
          }
        }

        if (diet.foodKind == '점심') {
          if (sumData[0] < 500) {
            dietMessages = "너무 적게 먹었습니다!";
          } else if (sumData[0] >= 560 && sumData[0] <= 840) {
            dietMessages = "적당하게 먹었습니다!";
          } else {
            dietMessages = "너무 많이 먹었습니다!";
          }
        }

        if (diet.foodKind == '저녁') {
          if (sumData[0] < 480) {
            dietMessages = "너무 적게 먹었습니다!";
          } else if (sumData[0] >= 480 && sumData[0] <= 720) {
            dietMessages = "적당하게 먹었습니다!";
          } else {
            dietMessages = "너무 많이 먹었습니다!";
          }
        }

        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: GestureDetector(
            onTap: () {
              Get.to(() => DietI(), arguments: diet.id);
            },
            child: Card(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgSizedBox(
                            path: 'icons/category/protein_category.svg',
                            data: sumData[1]
                        ),

                        SvgSizedBox(
                            path: 'icons/category/carbohy_category.svg',
                            data: sumData[2]
                        ),

                        SvgSizedBox(
                            path: 'icons/category/sugar_category.svg',
                            data: sumData[3]
                        ),

                        SvgSizedBox(
                            path: 'icons/category/fat_category.svg',
                            data: sumData[4]
                        )
                      ]
                    ),
                  ),

                  ListTile(
                      title: Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < diet.foodList.length; i += Widgets().i())
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int j = i; j < i + Widgets().i() && j < diet.foodList.length; j++)
                                    Container(
                                      constraints: BoxConstraints(
                                          minWidth: 100,
                                          minHeight: 40
                                      ),
                                      child: Card(
                                        color: Const().buildColors()[2],
                                        child: Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomText(
                                                    message: diet.foodList[j].foodName.length > 10 ? "${diet.foodList[j].foodName.substring(0, 9)}..." : diet.foodList[j].foodName,
                                                    fontSize: 11,
                                                    fontFamily: 'PaperLogyMedium',
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ),

                                              Text(
                                                "${diet.foodList[j].energyKcal} kcal",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dietMessages,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey
                                    ),
                                  ),

                                  Text(
                                    "${diet.foodDate.hour}시 ${diet.foodDate.minute}분 - ${diet.foodKind}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MoisItemState extends State<Item<Mois>> {
  final constController = Get.put(ConstController());
  final moisController = Get.put(MoisController());

  @override
  Widget build(BuildContext context) {
    // 수분 합계 계산
    final double sumAmount = widget.data.fold<double>(
      0.0,
          (sum, m) => sum + (m.amountMois),
    );

    double waterLevel = (sumAmount / constController.dailyGoal.value).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 40, top: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 12.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "하루 수분 섭취량 (권장): 체중 1kg당 약 30~35ml",
                style: TextStyle(
                  fontSize: 12,
                  color: Const().buildColors()[1]
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                CustomPaint(
                  size: const Size(120, 120),
                  painter: CupPainter(
                      waterLevel: waterLevel,
                      repaint: MoisController().currentWaterNotifier
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, right: 6),
                    child: Text(
                      "오늘의 수분은? \n${waterLevel}L를 채웠어요!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Const().buildColors()[1],
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}