// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TempUser _$TempUserFromJson(Map<String, dynamic> json) => TempUser(
  id: (json['id'] as num?)?.toInt(),
  deviceId: json['device_id'] as String?,
  weight: (json['weight'] as num).toDouble(),
  userCode: json['user_code'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$TempUserToJson(TempUser instance) => <String, dynamic>{
  'id': ?instance.id,
  'device_id': ?instance.deviceId,
  'weight': instance.weight,
  'user_code': instance.userCode,
  'created_at': instance.createdAt.toIso8601String(),
};
