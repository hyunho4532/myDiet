import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food {
  @JsonKey(name: 'food_code', defaultValue: '')
  final String foodCode;

  @JsonKey(name: 'food_name', defaultValue: '')
  final String foodName;

  @JsonKey(name: 'data_type_code', defaultValue: '')
  final String dataTypeCode;

  @JsonKey(name: 'data_type_name', defaultValue: '')
  final String dataTypeName;

  @JsonKey(name: 'food_origin_code', defaultValue: '')
  final String foodOriginCode;

  @JsonKey(name: 'food_origin_name', defaultValue: '')
  final String foodOriginName;

  @JsonKey(name: 'food_major_category_code', defaultValue: '')
  final String foodMajorCategoryCode;

  @JsonKey(name: 'food_major_category_name', defaultValue: '')
  final String foodMajorCategoryName;

  @JsonKey(name: 'representative_food_code', defaultValue: '')
  final String representativeFoodCode;

  @JsonKey(name: 'representative_food_name', defaultValue: '')
  final String representativeFoodName;

  @JsonKey(name: 'food_middle_category_code', defaultValue: '')
  final String foodMiddleCategoryCode;

  @JsonKey(name: 'food_middle_category_name', defaultValue: '')
  final String foodMiddleCategoryName;

  @JsonKey(name: 'food_sub_category_code', defaultValue: '')
  final String foodSubCategoryCode;

  @JsonKey(name: 'food_sub_category_name', defaultValue: '')
  final String foodSubCategoryName;

  @JsonKey(name: 'food_detail_category_code', defaultValue: '')
  final String foodDetailCategoryCode;

  @JsonKey(name: 'food_detail_category_name', defaultValue: '')
  final String foodDetailCategoryName;

  @JsonKey(name: 'nutrition_reference_amount', defaultValue: '')
  final String nutritionReferenceAmount;

  @JsonKey(name: 'energy_kcal', defaultValue: 0.0)
  final double energyKcal;

  @JsonKey(name: 'water_g', defaultValue: 0.0)
  final double waterG;

  @JsonKey(name: 'protein_g', defaultValue: 0.0)
  final double proteinG;

  @JsonKey(name: 'fat_g', defaultValue: 0.0)
  final double fatG;

  @JsonKey(name: 'ash_g', defaultValue: 0.0)
  final double ashG;

  @JsonKey(name: 'carbohydrate_g', defaultValue: 0.0)
  final double carbohydrateG;

  @JsonKey(name: 'sugars_g', defaultValue: 0.0)
  final double sugarsG;

  @JsonKey(name: 'dietary_fiber_g', defaultValue: 0.0)
  final double dietaryFiberG;

  @JsonKey(name: 'calcium_mg', defaultValue: 0.0)
  final double calciumMg;

  @JsonKey(name: 'iron_mg', defaultValue: 0.0)
  final double ironMg;

  @JsonKey(name: 'phosphorus_mg', defaultValue: 0.0)
  final double phosphorusMg;

  @JsonKey(name: 'potassium_mg', defaultValue: 0.0)
  final double potassiumMg;

  @JsonKey(name: 'sodium_mg', defaultValue: 0.0)
  final double sodiumMg;

  @JsonKey(name: 'vitamin_a_μg_rae', defaultValue: 0.0)
  final double vitaminARae;

  @JsonKey(name: 'retinol_μg', defaultValue: 0.0)
  final double retinol;

  @JsonKey(name: 'beta_carotene_μg', defaultValue: 0.0)
  final double betaCarotene;

  @JsonKey(name: 'thiamin_mg', defaultValue: 0.0)
  final double thiaminMg;

  @JsonKey(name: 'riboflavin_mg', defaultValue: 0.0)
  final double riboflavinMg;

  @JsonKey(name: 'niacin_mg', defaultValue: 0.0)
  final double niacinMg;

  @JsonKey(name: 'vitamin_c_mg', defaultValue: 0.0)
  final double vitaminCMg;

  @JsonKey(name: 'vitamin_d_μg', defaultValue: 0.0)
  final double vitaminDMicrog;

  @JsonKey(name: 'cholesterol_mg', defaultValue: 0.0)
  final double cholesterolMg;

  @JsonKey(name: 'saturated_fat_g', defaultValue: 0.0)
  final double saturatedFatG;

  @JsonKey(name: 'trans_fat_g', defaultValue: 0.0)
  final double transFatG;

  @JsonKey(name: 'source_code', defaultValue: '')
  final String sourceCode;

  @JsonKey(name: 'source_name', defaultValue: '')
  final String sourceName;

  @JsonKey(name: 'food_weight', defaultValue: '')
  final String foodWeight;

  @JsonKey(name: 'manufacturer', defaultValue: '')
  final String manufacturer;

  @JsonKey(name: 'data_creation_method_code', defaultValue: '')
  final String dataCreationMethodCode;

  @JsonKey(name: 'data_creation_method_name', defaultValue: '')
  final String dataCreationMethodName;

  @JsonKey(name: 'data_creation_date', defaultValue: '')
  final String dataCreationDate;

  @JsonKey(name: 'data_reference_date', defaultValue: '')
  final String dataReferenceDate;

  Food({
    required this.foodCode,
    required this.foodName,
    required this.dataTypeCode,
    required this.dataTypeName,
    required this.foodOriginCode,
    required this.foodOriginName,
    required this.foodMajorCategoryCode,
    required this.foodMajorCategoryName,
    required this.representativeFoodCode,
    required this.representativeFoodName,
    required this.foodMiddleCategoryCode,
    required this.foodMiddleCategoryName,
    required this.foodSubCategoryCode,
    required this.foodSubCategoryName,
    required this.foodDetailCategoryCode,
    required this.foodDetailCategoryName,
    required this.nutritionReferenceAmount,
    required this.energyKcal,
    required this.waterG,
    required this.proteinG,
    required this.fatG,
    required this.ashG,
    required this.carbohydrateG,
    required this.sugarsG,
    required this.dietaryFiberG,
    required this.calciumMg,
    required this.ironMg,
    required this.phosphorusMg,
    required this.potassiumMg,
    required this.sodiumMg,
    required this.vitaminARae,
    required this.retinol,
    required this.betaCarotene,
    required this.thiaminMg,
    required this.riboflavinMg,
    required this.niacinMg,
    required this.vitaminCMg,
    required this.vitaminDMicrog,
    required this.cholesterolMg,
    required this.saturatedFatG,
    required this.transFatG,
    required this.sourceCode,
    required this.sourceName,
    required this.foodWeight,
    required this.manufacturer,
    required this.dataCreationMethodCode,
    required this.dataCreationMethodName,
    required this.dataCreationDate,
    required this.dataReferenceDate,
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
