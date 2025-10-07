// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diet _$DietFromJson(Map<String, dynamic> json) => Diet(
  id: (json['id'] as num?)?.toInt(),
  userId: json['user_id'] as String?,
  foodType: json['food_type'] as String,
  foodKind: json['food_kind'] as String?,
  foodAmount: json['food_amount'] as String?,
  foodDate: DateTime.parse(json['food_date'] as String),
  foodList:
      (json['food_list'] as List<dynamic>)
          .map((e) => Food.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$DietToJson(Diet instance) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  if (instance.userId case final value?) 'user_id': value,
  'food_type': instance.foodType,
  if (instance.foodKind case final value?) 'food_kind': value,
  if (instance.foodAmount case final value?) 'food_amount': value,
  'food_date': instance.foodDate.toIso8601String(),
  'food_list': instance.foodList,
};
