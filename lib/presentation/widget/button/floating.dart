import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/screens/feature/diet_i.dart';

class Floating extends StatefulWidget {
  final Icon icon;

  const Floating({
    super.key,
    required this.icon
  });

  @override
  State<Floating> createState() => _FloatingState();
}

class _FloatingState extends State<Floating> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FloatingActionButton(
        backgroundColor: Const().buildColors()[0],
        onPressed: () {
          Get.to(DietI());
        },
        child: widget.icon,
      ),
    );
  }
}
