import 'package:json_annotation/json_annotation.dart';

part 'height_kcal.g.dart';

@JsonSerializable()
class HeightKcal {
  @JsonKey(name: 'height', defaultValue: 0)
  final int height;

  @JsonKey(name: 'food_date')
  final DateTime foodDate;

  @JsonKey(name: 'diet_id')
  final int dietId;

  @JsonKey(name: 'sum_kcal')
  final double sumKcal;

  HeightKcal({
    required this.height,
    required this.foodDate,
    required this.dietId,
    required this.sumKcal
  });

  factory HeightKcal.fromJson(Map<String, dynamic> json) => _$HeightKcalFromJson(json);

  Map<String, dynamic> toJson() => _$HeightKcalToJson(this);
}