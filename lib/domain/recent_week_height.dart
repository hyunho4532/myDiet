import 'package:json_annotation/json_annotation.dart';

part 'recent_week_height.g.dart';

/// 최근 주에 해당하는 몸무게 조회
@JsonSerializable(includeIfNull: false)
class RecentWeekHeight {
  @JsonKey(name: 'food_date')
  DateTime foodDate;

  @JsonKey(name: 'weight')
  double weight;

  RecentWeekHeight({
    required this.foodDate,
    required this.weight
  });

  factory RecentWeekHeight.fromJson(Map<String, dynamic> json) => _$RecentWeekHeightFromJson(json);

  Map<String, dynamic> toJson() => _$RecentWeekHeightToJson(this);
}