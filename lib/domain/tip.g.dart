// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tip _$TipFromJson(Map<String, dynamic> json) => Tip(
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  linkUrl: json['link_url'] as String? ?? '',
  source: json['source'] as String? ?? '',
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$TipToJson(Tip instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'link_url': instance.linkUrl,
  'source': instance.source,
  'created_at': instance.createdAt.toIso8601String(),
};
