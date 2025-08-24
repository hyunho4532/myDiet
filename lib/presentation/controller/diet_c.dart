import 'package:get/get.dart';
import 'package:mydiet/data/repository/diet_r.dart';
import 'package:mydiet/data/repository/food_r.dart';
import 'package:mydiet/domain/diet.dart';
import 'package:mydiet/domain/food.dart';

class DietController extends GetxController {
  var diets = <Diet>[].obs;

  // 음식 리스트 관리 (식단 관리)
  var foods = <Food>[].obs;

  var selectedDate = DateTime.now().obs;

  Future<void> fetchDiet() {
    return DietRepository().fetchDiet((data) {
      diets.value = data.map((e) => Diet.fromJson(e)).toList();
    });
  }

  // 특정 다이어트의 foodKind 수정
  void setFoodKind(int id, String foodKind) {
    final index = diets.indexWhere((d) => d.id == id);
    if (index != -1) {
      diets[index] = Diet(
        foodType: '',
        foodKind: foodKind,
        foodAmount: diets[index].foodAmount,
        foodDate: DateTime.now(),
        foodList: []
      );
    }
  }

  void setFoodDate(DateTime date) {
    selectedDate.value = date;
  }

  // 식단 추가
  void setFoodList(int id, Food food) {
    foods.add(food);
  }

  // 식단 삭제
  void deleteFoodList(int id, Food food) {
    foods.removeAt(id);
  }

  // 조회 함수
  List<Food> getFoodList(int dietId) {
    return foods;
  }

  void insert(Diet diet) {
    FoodRepository().insert(diet);
  }
}