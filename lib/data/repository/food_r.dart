import 'package:mydiet/domain/diet.dart';
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

  void insert(Diet diet) async {
    await _client
        .from('Diet')
        .insert(diet);
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