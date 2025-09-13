// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ratio _$RatioFromJson(Map<String, dynamic> json) => Ratio(
  proteinPct: (json['protein_pct'] as num?)?.toInt(),
  fatPct: (json['fat_pct'] as num?)?.toInt(),
  carbPct: (json['carb_pct'] as num?)?.toInt(),
  vitaminPct: (json['vitamin_pct'] as num?)?.toInt(),
);

Map<String, dynamic> _$RatioToJson(Ratio instance) => <String, dynamic>{
  if (instance.proteinPct case final value?) 'protein_pct': value,
  if (instance.fatPct case final value?) 'fat_pct': value,
  if (instance.carbPct case final value?) 'carb_pct': value,
  if (instance.vitaminPct case final value?) 'vitamin_pct': value,
};
