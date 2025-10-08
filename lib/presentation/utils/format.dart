import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Format {
  String formatDateTime(DateTime date) {
    return "${date.month}월 ${date.day}일 ${date.hour.toString().padLeft(2, '0')}시 ${date.minute.toString().padLeft(2, '0')}분";
  }

  double width(BuildContext context, {double? webFactor, double? mobile}) {
    if (kIsWeb) {
      double screenWidth = MediaQuery.of(context).size.width;
      return screenWidth * (webFactor ?? 0.8);
    } else if (Platform.isAndroid || Platform.isIOS) {
      return mobile!;
    } else {
      throw Exception();
    }
  }

  MainAxisAlignment axisAlignment() {
    if (kIsWeb) {
      return MainAxisAlignment.spaceBetween;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return MainAxisAlignment.spaceEvenly;
    } else {
      throw Exception();
    }
  }
}