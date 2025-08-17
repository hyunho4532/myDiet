import 'package:json_annotation/json_annotation.dart';

part 'diet.g.dart';

@JsonSerializable()
class Diet {
  final int id;

  // 식사 종류
  @JsonKey(name: 'food_kind')
  final String foodKind;

  // 식사량
  @JsonKey(name: 'food_amount')
  final String foodAmount;

  Diet({
    required this.id,
    required this.foodKind,
    required this.foodAmount
  });

  factory Diet.fromJson(Map<String, dynamic> json) => _$DietFromJson(json);

  Map<String, dynamic> toJson() => _$DietToJson(this);
}