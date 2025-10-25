import 'package:mydiet/domain/diet.dart';
import 'package:mydiet/domain/weight_kcal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodRepository<T> {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> fetchFood(String search, Function(List<dynamic>) onSuccess) async {
    final response = await _client
        .from("Food")
        .select()
        .like('food_name', '%$search%');

    final data = response as List<dynamic>;
    onSuccess(data);
  }

  // 등록을 하면서, 식단 등록과 몸무게 기반 칼로리 계산을 한 후 등록한다.
  void insert(Diet diet, WeightKcal weightKcal) async {
    await _client
        .from('Diet')
        .insert(diet);
    
    await _client
      .from("WeightKcal")
      .insert(weightKcal);
  }

  void edit(Diet diet) async {
    await _client
        .from('Diet')
        .update({
          'id': diet.id,
          'food_type': diet.foodType,
          'food_kind': diet.foodKind,
          'food_amount': diet.foodAmount,
          'food_date': diet.foodDate.toIso8601String(),
          'food_list': diet.foodList
        })
        .eq('id', diet.id!);
  }
}