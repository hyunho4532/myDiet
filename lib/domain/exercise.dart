import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@JsonSerializable()
class Exercise {
  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'energy_kcal', defaultValue: 0.0)
  final double energyKcal;

  Exercise({
    required this.name,
    required this.energyKcal
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}