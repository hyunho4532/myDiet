import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:mydiet/presentation/controller/temp_user_c.dart';
import 'package:mydiet/presentation/controller/tip_c.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileS extends StatefulWidget {
  const ProfileS({super.key});

  @override
  State<ProfileS> createState() => _ProfileSState();
}

class _ProfileSState extends State<ProfileS> {
  final TempUserController tempUserController = Get.put(TempUserController());
  final TipController tipController = Get.put(TipController());
  final DietController dietController = Get.put(DietController(0));

  String message = "";

  @override
  void initState() {
    super.initState();

    tempUserController.validateTempUser().then((value) {
      setState(() {
        message = value;
      });
    });

    tipController.fetchTip();
    dietController.fetchDietWeekly();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32, left: 12),
                child: CircleAvatar(
                  radius: 20, // 크기
                  backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/9187/9187532.png"), // 이미지
                  backgroundColor: Colors.grey[200], // 이미지 없을 때 배경색
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 32, left: 8),
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12, right: 12),
            child: SizedBox(
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
                              Text(
                                tip.title,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold
                                ),
                              ),

                              const Spacer(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${tip.category} - ${tip.source}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Const().buildColors()[2],
                                        fontWeight: FontWeight.bold
                                      ),
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
          ),

          const SizedBox(height: 24),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "나의 일주일 식단 확인하기",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12, right: 12),
            child: SizedBox(
              height: 150,
              child: Obx(() => GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.5
                ),
                itemCount: dietController.diets.length,
                itemBuilder: (context, index) {
                  final diet = dietController.diets[index];

                  return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < dietController.diets.length; i++)
                              Row(
                                children: [
                                  Text(
                                    diet.foodList[i].foodName,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey
                                    ),
                                  )
                                ],
                              )
                          ],
                        ),
                      )
                  );
                },
              )),
            ),
          ),
        ],
      ),
    );
  }
}