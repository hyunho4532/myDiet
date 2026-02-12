// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_week_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentWeekHeight _$RecentWeekHeightFromJson(Map<String, dynamic> json) =>
    RecentWeekHeight(
      foodDate: DateTime.parse(json['food_date'] as String),
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$RecentWeekHeightToJson(RecentWeekHeight instance) =>
    <String, dynamic>{
      'food_date': instance.foodDate.toIso8601String(),
      'weight': instance.weight,
    };
