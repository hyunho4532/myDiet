import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/domain/common_code.dart';

class Chips extends StatefulWidget {
  final String type;
  final int tags;
  final RxList<CommonCode> data;

  const Chips({
    super.key,
    required this.type,
    required this.tags,
    required this.data
  });

  @override
  State<Chips> createState() => _ChipState();
}

class _ChipState extends State<Chips> {
  @override
  Widget build(BuildContext context) {
    return ChipsChoice.single(
        value: widget.tags,
        onChanged: (val) {

        },
      choiceItems: C2Choice.listFrom<String, CommonCode>(
          source: widget.data,
          value: (i, item) => item.code,
          label: (i, item) => item.name
      ),
    );
  }
}
