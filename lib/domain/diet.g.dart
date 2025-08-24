// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diet _$DietFromJson(Map<String, dynamic> json) => Diet(
  id: (json['id'] as num).toInt(),
  foodKind: json['food_kind'] as String,
  foodAmount: json['food_amount'] as String,
  foodDate: DateTime.parse(json['food_date'] as String),
  foodList:
      (json['food_list'] as List<dynamic>)
          .map((e) => Food.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$DietToJson(Diet instance) => <String, dynamic>{
  if (instance.id != null) 'id': instance.id,
  'food_kind': instance.foodKind,
  'food_amount': instance.foodAmount,
  'food_date': instance.foodDate.toIso8601String(),
  'food_list': instance.foodList,
};
