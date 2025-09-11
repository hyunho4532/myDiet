import 'package:json_annotation/json_annotation.dart';
import 'package:mydiet/domain/food.dart';

part 'mois.g.dart';

// 수분 테이블
@JsonSerializable(includeIfNull: false)
class Mois {
  final int? id;

  // 수분량
  @JsonKey(name: 'amount_mois')
  final double amountMois;

  @JsonKey(name: 'mois_date')
  final DateTime moisDate;

  Mois({
      this.id,
      required this.amountMois,
      required this.moisDate
  });

  factory Mois.fromJson(Map<String, dynamic> json) => _$MoisFromJson(json);

  Map<String, dynamic> toJson() => _$MoisToJson(this);
}