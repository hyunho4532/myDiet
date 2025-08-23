import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:mydiet/presentation/const.dart';

class BottomPickers {
  void showDatePicker(BuildContext context) {
    BottomPicker.date(
      headerBuilder: (context) {
        return Row(
          children: [
            Text(
              '식사 날짜를 등록해주세요!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Const().buildColors()[0],
              ),
            ),
          ],
        );
      },
    ).show(context);
  }
}