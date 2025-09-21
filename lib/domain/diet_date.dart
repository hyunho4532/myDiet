import 'package:json_annotation/json_annotation.dart';

part 'diet_date.g.dart';

@JsonSerializable(includeIfNull: false)
class DietDate {
  @JsonKey(name: 'start_date')
  DateTime? startDate;

  @JsonKey(name: 'end_date')
  DateTime? endDate;

  DietDate({
    this.startDate,
    this.endDate
  });

  factory DietDate.fromJson(Map<String, dynamic> json) => _$DietDateFromJson(json);

  Map<String, dynamic> toJson() => _$DietDateToJson(this);
}