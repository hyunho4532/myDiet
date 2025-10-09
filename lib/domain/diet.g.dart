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
  foodList: (json['food_list'] as List<dynamic>)
      .map((e) => Food.fromJson(e as Map<String, dynamic>))
      .toList(),
  isFavorite: json['is_favorite'] as bool,
);

Map<String, dynamic> _$DietToJson(Diet instance) => <String, dynamic>{
  'id': ?instance.id,
  'user_id': ?instance.userId,
  'food_type': instance.foodType,
  'food_kind': ?instance.foodKind,
  'food_amount': ?instance.foodAmount,
  'food_date': instance.foodDate.toIso8601String(),
  'food_list': instance.foodList,
  'is_favorite': instance.isFavorite,
};
