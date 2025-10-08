import 'package:json_annotation/json_annotation.dart';

part 'tip.g.dart';

@JsonSerializable()
class Tip {
  @JsonKey(name: 'title', defaultValue: '')
  final String title;

  @JsonKey(name: 'description', defaultValue: '')
  final String description;

  @JsonKey(name: 'link_url', defaultValue: '')
  final String linkUrl;

  @JsonKey(name: 'source', defaultValue: '')
  final String source;

  @JsonKey(name: 'created_at', defaultValue: '')
  final DateTime createdAt;


  Tip({
    required this.title,
    required this.description,
    required this.linkUrl,
    required this.source,
    required this.createdAt
  });

  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);
  Map<String, dynamic> toJson() => _$TipToJson(this);
}