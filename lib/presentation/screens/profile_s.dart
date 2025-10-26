import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/controller/temp_user_c.dart';
import 'package:mydiet/presentation/controller/tip_c.dart';
import 'package:mydiet/presentation/utils/math.dart';
import 'package:mydiet/presentation/widget/sizedbox/svg_sizedbox.dart';
import 'package:mydiet/presentation/widget/text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mydiet/presentation/widget/chart/line_chart.dart';

class ProfileS extends StatefulWidget {
  const ProfileS({super.key});

  @override
  State<ProfileS> createState() => _ProfileSState();
}

class _ProfileSState extends State<ProfileS> {
  late bool isShowingMainData;

  final TempUserController tempUserController = Get.put(TempUserController());
  final TipController tipController = Get.put(TipController());
  final DietController dietController = Get.put(DietController(0));

  String message = "";

  @override
  void initState() {
    super.initState();

    isShowingMainData = true;

    tempUserController.validateTempUser().then((value) {
      setState(() {
        message = value;
      });
    });

    tipController.fetchTip();
    dietController.fetchDiet();
    dietController.fetchRecentWeekHeights();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20, // 크기
                    backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/9187/9187532.png"), // 이미지
                    backgroundColor: Colors.grey[200], // 이미지 없을 때 배경색
                  ),

                  const SizedBox(width: 8),

                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'PyeojinGothicBold'
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              SizedBox(
                height: 90,
                child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tipController.tips.length,
                  itemBuilder: (context, index) {
                    final tip = tipController.tips[index];
                    final url = Uri.parse(tip.linkUrl);

                    return SizedBox(
                      width: 170,
                      child: InkWell(
                        onTap: () {
                          launchUrl(url);
                        },
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    message: tip.title,
                                    fontSize: 12,
                                    fontFamily: 'PaperLogyMedium',
                                    color: Colors.grey
                                ),

                                const Spacer(),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                          message: "${tip.category} - ${tip.source}",
                                          fontSize: 11,
                                          fontFamily: 'PaperLogyMedium',
                                          color: Colors.grey
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                    );
                  },
                )),
              ),

              const SizedBox(height: 24),

              const Text(
                "나의 식단 확인하기",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'PyeojinGothicBold'
                ),
              ),

              const SizedBox(height: 8),

              Obx(() => SizedBox(
                height: 200,
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.70
                  ),
                  itemCount: dietController.diets.length,
                  itemBuilder: (context, index) {
                    final diet = dietController.diets[index];

                    // 합계 계산
                    final sumData = Math().sumArray(diet);

                    return GestureDetector(
                      onTap: () {
                        dietController.setFavoriteDiet(diet.id!);
                      },
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < min(2, diet.foodList.length); i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 1.0), // 줄 간격 조정
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                            message: diet.foodList[i].foodName.length > 13
                                                ? "${diet.foodList[i].foodName.substring(0, 12)}..."
                                                : diet.foodList[i].foodName,
                                            fontSize: 12,
                                            fontFamily: 'PaperLogyMedium',
                                            color: Colors.grey
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              const SizedBox(height: 6),

                              Row(
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
                                  ]
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgSizedBox(
                                      path: 'icons/category/sugar_category.svg',
                                      data: sumData[3]
                                  ),

                                  SvgSizedBox(
                                      path: 'icons/category/fat_category.svg',
                                      data: sumData[4]
                                  )
                                ],
                              ),

                              const Spacer(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      diet.isFavorite == true ? 'icons/bookmark_solid.svg' : 'icons/bookmark.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),

              const SizedBox(height: 24),

              const Text(
                "현재 내 상태는?",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'PyeojinGothicBold'
                ),
              ),

              const SizedBox(height: 6),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: HeightLineChart(
                    isShowingMainData: isShowingMainData,
                    data: dietController.recentWeekHeights
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    message: "몸무게",
                    fontSize: 11.0,
                    fontFamily: "PyeojinGothicMedium",
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 8),

                  Container(
                    width: 26,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Const().buildColors()[2], // 색상
                      borderRadius: BorderRadius.circular(20), // 둥근 정도
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}