class Math<T> {
  /// 합계 구하기
  double sumBy(List<T> data, double Function(dynamic) selector) {
    return data.fold(
      0.0,
      (sum, item) => sum += selector(item),
    );
  }
}