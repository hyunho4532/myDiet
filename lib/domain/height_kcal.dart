import 'package:json_annotation/json_annotation.dart';

part 'height_kcal.g.dart';

@JsonSerializable()
class HeightKcal {
  @JsonKey(name: 'height', defaultValue: 0)
  final int height;

  @JsonKey(name: 'food_date')
  final DateTime foodDate;

  HeightKcal({
    required this.height,
    required this.foodDate
  });

  factory HeightKcal.fromJson(Map<String, dynamic> json) => _$HeightKcalFromJson(json);

  Map<String, dynamic> toJson() => _$HeightKcalToJson(this);
}