// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mois.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mois _$MoisFromJson(Map<String, dynamic> json) => Mois(
  id: (json['id'] as num?)?.toInt(),
  amountMois: (json['amount_mois'] as num).toInt(),
  moisDate: DateTime.parse(json['mois_date'] as String),
);

Map<String, dynamic> _$MoisToJson(Mois instance) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  'amount_mois': instance.amountMois,
  'mois_date': instance.moisDate.toIso8601String(),
};
