// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diet _$DietFromJson(Map<String, dynamic> json) => Diet(
  id: (json['id'] as num).toInt(),
  foodKind: json['food_kind'] as String,
  foodAmount: json['food_amount'] as String,
);

Map<String, dynamic> _$DietToJson(Diet instance) => <String, dynamic>{
  'id': instance.id,
  'food_kind': instance.foodKind,
  'food_amount': instance.foodAmount,
};
