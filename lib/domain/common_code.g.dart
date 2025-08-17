// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonCode _$CommonCodeFromJson(Map<String, dynamic> json) => CommonCode(
  id: (json['id'] as num).toInt(),
  groupKey: json['group_key'] as String,
  code: json['code'] as String,
  name: json['name'] as String,
  index: (json['index'] as num).toInt(),
  createDate: DateTime.parse(json['create_date'] as String),
);

Map<String, dynamic> _$CommonCodeToJson(CommonCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_key': instance.groupKey,
      'code': instance.code,
      'name': instance.name,
      'index': instance.index,
      'create_date': instance.createDate.toIso8601String(),
    };
