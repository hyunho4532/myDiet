import 'package:supabase_flutter/supabase_flutter.dart';

class CommonRepository<T> {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> fetchCommon(String groupKey, Function(List<dynamic>) onSuccess) async {
    final response = await _client.from("CommonCode").select().eq('group_key', groupKey);

    final data = response as List<dynamic>;
    onSuccess(data);
  }
}