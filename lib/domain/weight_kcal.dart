import 'package:json_annotation/json_annotation.dart';

part 'weight_kcal.g.dart';

@JsonSerializable()
class WeightKcal {
  @JsonKey(name: 'weight', defaultValue: 0)
  final double weight;

  @JsonKey(name: 'food_date')
  final DateTime foodDate;

  @JsonKey(name: 'diet_id')
  final int dietId;

  @JsonKey(name: 'sum_kcal')
  final double sumKcal;

  WeightKcal({
    required this.weight,
    required this.foodDate,
    required this.dietId,
    required this.sumKcal
  });

  factory WeightKcal.fromJson(Map<String, dynamic> json) => _$WeightKcalFromJson(json);

  Map<String, dynamic> toJson() => _$WeightKcalToJson(this);
}