import 'package:supabase_flutter/supabase_flutter.dart';

class TipRepository<T> {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> fetchTip(Function(List<dynamic>) onSuccess) async {
    final response = await _client
        .from("Tip")
        .select();

    final data = response as List<dynamic>;
    onSuccess(data);
  }
}