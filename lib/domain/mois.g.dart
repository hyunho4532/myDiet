// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mois.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mois _$MoisFromJson(Map<String, dynamic> json) => Mois(
  id: (json['id'] as num?)?.toInt(),
  amountMois: (json['amount_mois'] as num).toDouble(),
  moisDate: DateTime.parse(json['mois_date'] as String),
);

Map<String, dynamic> _$MoisToJson(Mois instance) => <String, dynamic>{
  'id': ?instance.id,
  'amount_mois': instance.amountMois,
  'mois_date': instance.moisDate.toIso8601String(),
};
