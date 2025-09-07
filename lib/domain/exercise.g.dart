// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
  name: json['name'] as String? ?? '',
  energyKcal: (json['energy_kcal'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
  'name': instance.name,
  'energy_kcal': instance.energyKcal,
};
