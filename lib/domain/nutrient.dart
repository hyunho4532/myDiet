import 'package:json_annotation/json_annotation.dart';

part 'nutrient.g.dart';

// 영양소 집계 테이블
@JsonSerializable(includeIfNull: false)
class Nutrient {
  @JsonKey(name: 'protein_g')
  final double proteinG;

  @JsonKey(name: 'fat_g')
  final double fatG;

  @JsonKey(name: 'carb_g')
  final double carbG;

  @JsonKey(name: 'vitamin_total')
  final double vitaminTotal;

  Nutrient({
    required this.proteinG,
    required this.fatG,
    required this.carbG,
    required this.vitaminTotal
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) => _$NutrientFromJson(json);

  Map<String, dynamic> toJson() => _$NutrientToJson(this);
}