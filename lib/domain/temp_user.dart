import 'package:json_annotation/json_annotation.dart';
import 'package:mydiet/domain/food.dart';

part 'temp_user.g.dart';

// 식단 테이블
@JsonSerializable(includeIfNull: false)
class TempUser {
  final int? id;

  // 디바이스 ID
  @JsonKey(name: 'device_id')
  final String? deviceId;

  // 몸무게
  @JsonKey(name: 'weight')
  final double weight;

  // 사용자 코드
  @JsonKey(name: 'user_code')
  final String userCode;

  // 등록 날짜
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  TempUser({
    this.id,
    required this.deviceId,
    required this.weight,
    required this.userCode,
    required this.createdAt
  });

  factory TempUser.fromJson(Map<String, dynamic> json) => _$TempUserFromJson(json);

  Map<String, dynamic> toJson() => _$TempUserToJson(this);
}