// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'height_kcal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeightKcal _$HeightKcalFromJson(Map<String, dynamic> json) => HeightKcal(
  height: (json['height'] as num?)?.toInt() ?? 0,
  foodDate: DateTime.parse(json['food_date'] as String),
  dietId: (json['diet_id'] as num).toInt(),
  sumKcal: (json['sum_kcal'] as num).toDouble(),
);

Map<String, dynamic> _$HeightKcalToJson(HeightKcal instance) =>
    <String, dynamic>{
      'height': instance.height,
      'food_date': instance.foodDate.toIso8601String(),
      'diet_id': instance.dietId,
      'sum_kcal': instance.sumKcal,
    };
