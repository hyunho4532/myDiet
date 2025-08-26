class Math {
  /// 합계 구하기
  double sumBy(dynamic data, double Function(dynamic) selector) {
    return data.foodList.fold(
      0.0,
      (sum, item) => sum += selector(item),
    ) as double;
  }
}