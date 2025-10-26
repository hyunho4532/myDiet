// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_kcal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightKcal _$WeightKcalFromJson(Map<String, dynamic> json) => WeightKcal(
  userId: json['user_id'] as String,
  weight: (json['weight'] as num?)?.toDouble() ?? 0,
  foodDate: DateTime.parse(json['food_date'] as String),
  dietId: (json['diet_id'] as num).toInt(),
  sumKcal: (json['sum_kcal'] as num).toDouble(),
);

Map<String, dynamic> _$WeightKcalToJson(WeightKcal instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'weight': instance.weight,
      'food_date': instance.foodDate.toIso8601String(),
      'diet_id': instance.dietId,
      'sum_kcal': instance.sumKcal,
    };
