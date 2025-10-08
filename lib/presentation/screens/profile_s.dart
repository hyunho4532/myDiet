import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/controller/temp_user_c.dart';

class ProfileS extends StatefulWidget {
  const ProfileS({super.key});

  @override
  State<ProfileS> createState() => _ProfileSState();
}

class _ProfileSState extends State<ProfileS> {
  final TempUserController tempUserController = Get.put(TempUserController());

  String message = "";

  @override
  void initState() {
    super.initState();

    tempUserController.validateTempUser().then((value) {
      setState(() {
        message = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
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
          )
        ],
      ),
    );
  }
}