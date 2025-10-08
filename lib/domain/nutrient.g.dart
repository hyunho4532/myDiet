// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nutrient _$NutrientFromJson(Map<String, dynamic> json) => Nutrient(
  proteinG: (json['protein_g'] as num).toDouble(),
  fatG: (json['fat_g'] as num).toDouble(),
  carbG: (json['carb_g'] as num).toDouble(),
  vitaminTotal: (json['vitamin_total'] as num).toDouble(),
);

Map<String, dynamic> _$NutrientToJson(Nutrient instance) => <String, dynamic>{
  'protein_g': instance.proteinG,
  'fat_g': instance.fatG,
  'carb_g': instance.carbG,
  'vitamin_total': instance.vitaminTotal,
};
