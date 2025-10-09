import 'package:json_annotation/json_annotation.dart';
import 'package:mydiet/domain/food.dart';

part 'diet.g.dart';

// 식단 테이블
@JsonSerializable(includeIfNull: false)
class Diet {
  final int? id;

  @JsonKey(name: 'user_id')
  final String? userId;

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

  @JsonKey(name: 'is_favorite')
  final bool isFavorite;

  Diet({
    this.id,
    required this.userId,
    required this.foodType,
    required this.foodKind,
    required this.foodAmount,
    required this.foodDate,
    required this.foodList,
    required this.isFavorite
  });

  factory Diet.fromJson(Map<String, dynamic> json) => _$DietFromJson(json);

  Map<String, dynamic> toJson() => _$DietToJson(this);
}