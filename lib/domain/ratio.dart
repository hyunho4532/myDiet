import 'package:json_annotation/json_annotation.dart';
import 'package:mydiet/domain/food.dart';

part 'radio.g.dart';

@JsonSerializable(includeIfNull: false)
class Ratio {
  @JsonKey(name: 'protein_pct')
  final int? proteinPct;

  @JsonKey(name: 'fat_pct')
  final int? fatPct;

  @JsonKey(name: 'carb_pct')
  final int? carbPct;

  @JsonKey(name: 'vitamin_pct')
  final int? vitaminPct;

  Ratio({
    this.proteinPct,
    this.fatPct,
    this.carbPct,
    this.vitaminPct
  });
}