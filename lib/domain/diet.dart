import 'package:json_annotation/json_annotation.dart';
import 'package:mydiet/domain/food.dart';

part 'diet.g.dart';

@JsonSerializable()
class Diet {
  final int? id;

  // 식사 타입
  @JsonKey(name: 'food_type')
  final String foodType;

  // 식사 종류
  @JsonKey(name: 'food_kind')
  final String? foodKind;

  // 식사량
  @JsonKey(name: 'food_amount')
  final String? foodAmount;

  // 식사한 날짜
  @JsonKey(name: 'food_date')
  final DateTime foodDate;

  // 식단 정보
  @JsonKey(name: 'food_list')
  final List<Food> foodList;

  Diet({
    this.id,
    required this.foodType,
    required this.foodKind,
    required this.foodAmount,
    required this.foodDate,
    required this.foodList
  });

  factory Diet.fromJson(Map<String, dynamic> json) => _$DietFromJson(json);

  Map<String, dynamic> toJson() => _$DietToJson(this);
}