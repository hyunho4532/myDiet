import 'package:get/get.dart';
import 'package:mydiet/domain/diet.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DietRepository<T> {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> fetchDiet(Function(List<dynamic>) onSuccess) async {
    final response = await _client.from("Diet").select();

    final data = response as List<dynamic>;
    onSuccess(data);
  }

  Future<RxList<Diet>> dietById(int id) async {
    final response = await _client.from("Diet").select().eq("id", id);

    final data = (response as List<dynamic>)
        .map((json) => Diet.fromJson(json))
        .toList();

    return RxList<Diet>(data);
  }
}