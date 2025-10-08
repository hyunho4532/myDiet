import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/controller/temp_user_c.dart';
import 'package:mydiet/presentation/controller/tip_c.dart';

class ProfileS extends StatefulWidget {
  const ProfileS({super.key});

  @override
  State<ProfileS> createState() => _ProfileSState();
}

class _ProfileSState extends State<ProfileS> {
  final TempUserController tempUserController = Get.put(TempUserController());
  final TipController tipController = Get.put(TipController());

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
              height: 70,
              child: Obx(() => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tipController.tips.length,
                itemBuilder: (context, index) {
                  final tip = tipController.tips[index];
                  return SizedBox(
                    width: 140,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                        child: Column(
                          children: [
                            Text(
                              tip.title,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                  );
                },
              )),
            ),
          )
        ],
      ),
    );
  }
}