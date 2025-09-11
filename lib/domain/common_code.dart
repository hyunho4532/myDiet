import 'package:json_annotation/json_annotation.dart';

part 'common_code.g.dart';

@JsonSerializable()
class CommonCode {
  final int id;

  @JsonKey(name: 'group_key')
  final String groupKey;

  final String code;

  final String name;

  final int index;

  @JsonKey(name: 'create_date')
  final DateTime createDate;

  CommonCode({
    required this.id,
    required this.groupKey,
    required this.code,
    required this.name,
    required this.index,
    required this.createDate
  });

  factory CommonCode.fromJson(Map<String, dynamic> json) => _$CommonCodeFromJson(json);

  Map<String, dynamic> toJson() => _$CommonCodeToJson(this);
}