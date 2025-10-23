import 'package:mydiet/domain/diet.dart';

class Math<T> {
  /// 합계 구하기
  double sumBy(List<T> data, double Function(dynamic) selector) {
    return data.fold(
      0.0,
      (sum, item) => sum += selector(item),
    );
  }

  /// 합계를 배열로 묶어주기
  List<double> sumArray(Diet diet) {
    // 칼로리 합계
    final sumKcal = Math().sumBy(diet.foodList, (item) => item.energyKcal);

    // 단백질 합계
    final sumProtein = Math().sumBy(diet.foodList, (item) => item.proteinG);

    // 당류 합계
    final sumSugar = Math().sumBy(diet.foodList, (item) => item.sugarsG);

    // 지방 합계
    final sumFat = Math().sumBy(diet.foodList, (item) => item.fatG);

    // 탄수화물 합계
    final sumCarbohydrate = Math().sumBy(diet.foodList, (item) => item.carbohydrateG);

    return [ sumKcal, sumProtein, sumCarbohydrate, sumSugar, sumFat ];
  }
}