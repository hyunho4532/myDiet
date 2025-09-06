import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydiet/data/repository/mois_r.dart';
import 'package:mydiet/domain/mois.dart';

class MoisController extends GetxController {
  // 사용자가 마신 양 (물)
  var currentWater = 0.0.obs;
  ValueNotifier<double> currentWaterNotifier = ValueNotifier(0.0);

  // 수분 관리
  var moiss = <Mois>[].obs;

  Future<void> fetchMois() {
    return MoisRepository().fetchMois((data) {
      moiss.value = data.map((e) => Mois.fromJson(e)).toList();
    });
  }

  // 사용자가 마신 양 조절
  void onSelected(double value) {
    currentWater.value += value;
    currentWaterNotifier.value = currentWater.value;
  }

  void insert(Mois mois) {
    MoisRepository().insert(mois);
  }
}