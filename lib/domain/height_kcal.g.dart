// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'height_kcal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeightKcal _$HeightKcalFromJson(Map<String, dynamic> json) => HeightKcal(
  height: (json['height'] as num?)?.toInt() ?? 0,
  foodDate: DateTime.parse(json['food_date'] as String),
);

Map<String, dynamic> _$HeightKcalToJson(HeightKcal instance) =>
    <String, dynamic>{
      'height': instance.height,
      'food_date': instance.foodDate.toIso8601String(),
    };
