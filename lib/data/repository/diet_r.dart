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
  
  Future<void> fetchRatio(DateTime? startDate, DateTime? endDate, Function(List<dynamic>) onSuccess) async {
    final response = await _client.rpc(
      "get_nutrient_ratio_from_food_list",
      params: {
        "start_date": startDate!.toIso8601String(), // RPC 함수에서 정의한 파라미터명과 일치해야 함
        "end_date": endDate!.toIso8601String(),
      },
    );

    final data = response as List<dynamic>;
    onSuccess(data);
  }

  Future<void> fetchNutrient(DateTime? startDate, DateTime? endDate, Function(List<dynamic>) onSuccess) async {
    final response = await _client.rpc(
      "get_nutrient_from_food_list",
      params: {
        "start_date": startDate!.toIso8601String(), // RPC 함수에서 정의한 파라미터명과 일치해야 함
        "end_date": endDate!.toIso8601String(),
      },
    );

    final data = response as List<dynamic>;
    onSuccess(data);
  }

  Future<void> fetchDietDate(String type, Function(List<dynamic>) onSuccess) async {
    dynamic response;
    
    if (type == 'week') {
      response = await _client.rpc("get_start_end_date_week");
    } else {
      response = await _client.rpc("get_start_end_date_month");
    }

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