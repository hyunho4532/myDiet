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
}