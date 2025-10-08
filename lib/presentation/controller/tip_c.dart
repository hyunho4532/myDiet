import 'package:get/get.dart';
import 'package:mydiet/data/repository/tip_r.dart';
import 'package:mydiet/domain/tip.dart';

class TipController extends GetxController {
  var tips = <Tip>[].obs;

  // 팁 데이터들을 조회한다.
  Future<void> fetchTip() {
    return TipRepository().fetchTip((data) {
      tips.value = data.map((e) => Tip.fromJson(e)).toList();
    });
  }
}