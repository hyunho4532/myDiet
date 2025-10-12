// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ratio _$RatioFromJson(Map<String, dynamic> json) => Ratio(
  proteinPct: (json['protein_pct'] as num?)?.toDouble(),
  fatPct: (json['fat_pct'] as num?)?.toDouble(),
  carbPct: (json['carb_pct'] as num?)?.toDouble(),
  vitaminPct: (json['vitamin_pct'] as num?)?.toDouble(),
);

Map<String, dynamic> _$RatioToJson(Ratio instance) => <String, dynamic>{
  'protein_pct': ?instance.proteinPct,
  'fat_pct': ?instance.fatPct,
  'carb_pct': ?instance.carbPct,
  'vitamin_pct': ?instance.vitaminPct,
};
