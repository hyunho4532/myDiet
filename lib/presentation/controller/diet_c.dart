import 'package:get/get.dart';
import 'package:mydiet/data/repository/diet_r.dart';
import 'package:mydiet/data/repository/food_r.dart';
import 'package:mydiet/domain/diet.dart';
import 'package:mydiet/domain/diet_date.dart';
import 'package:mydiet/domain/food.dart';
import 'package:mydiet/domain/nutrient.dart';
import 'package:mydiet/domain/ratio.dart';

class DietController extends GetxController {

  DietController(this.id);

  final dynamic id;

  // 식단 관리
  var diets = <Diet>[].obs;

  // 비율 관리
  var ratios = <Ratio>[].obs;

  // 영양소 관리
  var nutrient = <Nutrient>[].obs;

  // 시작일, 종료일 관리
  var dietsDate = <DietDate>[].obs;

  // 음식 리스트 관리
  var foods = <Food>[].obs;

  var selectedDate = DateTime.now().obs;

  Future<void> fetchDiet() {
    return DietRepository().fetchDiet((data) {
      diets.value = data.map((e) => Diet.fromJson(e)).toList();
    });
  }

  /**
   * 식단 - 영양소, 비율 조회
   */
  Future<void> fetchDietInfo(DateTime? startDate, DateTime? endDate) async {
    await DietRepository().fetchRatio(startDate, endDate, (data) {
      ratios.value = data.map((e) => Ratio.fromJson(e)).toList();
    });

    await DietRepository().fetchNutrient(startDate, endDate, (data) {
      nutrient.value = data.map((e) => Nutrient.fromJson(e)).toList();
    });
  }

  Future<void> fetchDietDate(String type) {
    return DietRepository().fetchDietDate(type, (data) {
      dietsDate.value = data.map((e) => DietDate.fromJson(e)).toList();
      fetchDietInfo(dietsDate[0].startDate, dietsDate[0].endDate);
    });
  }

  Future<void> dietById(int id) async {
    final result = await DietRepository().dietById(id);

    for (var item in result) {
      selectedDate.value = item.foodDate;
      foods.value = item.foodList;
    }

    diets.assignAll(result);
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

  // 등록 함수
  void insert(Diet diet) {
    FoodRepository().insert(diet);
  }

  // 수정 함수
  void edit(Diet diet) {
    FoodRepository().edit(diet);
  }
}