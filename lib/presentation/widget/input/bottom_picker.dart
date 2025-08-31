import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:mydiet/presentation/controller/const_c.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';

class BottomPickers {
  void showDatePicker(BuildContext context, ConstController controller) {
    BottomPicker.dateTime(
      initialDateTime: controller.selectedDate.value,
      displaySubmitButton: false,
      onChange: (date) {
        print("BottomPicker $date");
        controller.selectedDate.value = date;
      },
    ).show(context);
  }
}