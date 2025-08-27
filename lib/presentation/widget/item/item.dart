import 'package:flutter/material.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/utils/math.dart';

class Item<T> extends StatefulWidget {
  final List<T> data;

  const Item({
    super.key,
    required this.data
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        final diet = widget.data[index];
        String dietMessages = "";

        // 칼로리 합계
        final sumKcal = Math().sumBy(diet, (item) => item.energyKcal);

        // 단백질 합계
        final sumProtein = Math().sumBy(diet, (item) => item.proteinG);

        // 당류 합계
        final sumSugar = Math().sumBy(diet, (item) => item.sugarsG);

        // 지방 합계
        final sumFat = Math().sumBy(diet, (item) => item.fatG);

        // 탄수화물 합계
        final sumCarbohydrate = Math().sumBy(diet, (item) => item.carbohydrateG);

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

        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  '단백질'
                                ),
                              ),

                              Center(
                                  child: Text(
                                      sumProtein.toStringAsFixed(2)
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                    '탄수화물'
                                ),
                              ),

                              Center(
                                  child: Text(
                                      sumCarbohydrate.toStringAsFixed(2)
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                    '당류'
                                  )
                              ),

                              Center(
                                  child: Text(
                                      sumSugar.toStringAsFixed(2)
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                    '지방'
                                  )
                              ),

                              Center(
                                  child: Text(
                                      sumFat.toStringAsFixed(2)
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ),
                ),

                ListTile(
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
                    ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
