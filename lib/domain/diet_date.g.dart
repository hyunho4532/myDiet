// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DietDate _$DietDateFromJson(Map<String, dynamic> json) => DietDate(
  startDate:
      json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
  endDate:
      json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
);

Map<String, dynamic> _$DietDateToJson(DietDate instance) => <String, dynamic>{
  if (instance.startDate?.toIso8601String() case final value?)
    'start_date': value,
  if (instance.endDate?.toIso8601String() case final value?) 'end_date': value,
};
