import 'package:json_annotation/json_annotation.dart';
import 'package:mydiet/domain/food.dart';

part 'ratio.g.dart';

// 영양성분 4대 합계 비율 테이블
@JsonSerializable(includeIfNull: false)
class Ratio {
  @JsonKey(name: 'protein_pct')
  final double? proteinPct;

  @JsonKey(name: 'fat_pct')
  final double? fatPct;

  @JsonKey(name: 'carb_pct')
  final double? carbPct;

  @JsonKey(name: 'vitamin_pct')
  final double? vitaminPct;

  Ratio({
    this.proteinPct,
    this.fatPct,
    this.carbPct,
    this.vitaminPct
  });

  factory Ratio.fromJson(Map<String, dynamic> json) => _$RatioFromJson(json);

  Map<String, dynamic> toJson() => _$RatioToJson(this);
}