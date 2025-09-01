import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoisController extends GetxController {
  // 사용자가 마신 양 (물)
  var currentWater = 0.0.obs;
  ValueNotifier<double> currentWaterNotifier = ValueNotifier(0.0);

  void onSelected(double value) {
    currentWater.value += value;
    currentWaterNotifier.value = currentWater.value;
  }
}