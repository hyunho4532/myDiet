import 'package:get/get.dart';
import 'package:mydiet/data/repository/food_r.dart';
import 'package:mydiet/domain/food.dart';

class FoodController extends GetxController {
  var foods = <Food>[].obs;

  // 검색된 음식 데이터들을 조회한다.
  Future<void> fetchFood(String search) {
    return FoodRepository().fetchFood(search, (data) {
      foods.value = data.map((e) => Food.fromJson(e)).toList();
    });
  }
}