import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/domain/common_code.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';

class Chips extends StatefulWidget {
  final String type;
  final int tags;
  final RxList<CommonCode> data;
  final Function(int)? onChanged;

  const Chips({
    super.key,
    required this.type,
    required this.tags,
    required this.data,
    this.onChanged
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
        if (widget.onChanged != null) {
          widget.onChanged!(val);
        }
      },
      choiceStyle: C2ChipStyle(
        backgroundColor: Colors.blue,
        overlayColor: Const().buildColors()[2],
        foregroundStyle: TextStyle(
          color: Colors.black
        ),
      ),
      choiceItems: C2Choice.listFrom<int, CommonCode>(
          source: widget.data,
          value: (i, item) => item.index,
          label: (i, item) => item.name
      ),
    );
  }
}
