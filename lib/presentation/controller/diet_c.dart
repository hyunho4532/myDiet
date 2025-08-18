import 'package:get/get.dart';
import 'package:mydiet/domain/diet.dart';

class DietController extends GetxController {
  var diets = <Diet>[].obs;

  var selectedDate = DateTime.now().obs;

  // 특정 다이어트의 foodKind 수정
  void setFoodKind(int id, String foodKind) {
    final index = diets.indexWhere((d) => d.id == id);
    if (index != -1) {
      diets[index] = Diet(
        id: diets[index].id,
        foodKind: foodKind,
        foodAmount: diets[index].foodAmount,
        foodDate: DateTime.now()
      );
    }
  }

  void setFoodDate(DateTime date) {
    selectedDate.value = date;
  }
}