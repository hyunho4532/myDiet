import 'package:supabase_flutter/supabase_flutter.dart';

class TempUserRepository<T> {
  final SupabaseClient _client = Supabase.instance.client;
  void insert(String deviceId) async {
    await _client.rpc(
      "set_temp_user",
      params: {
        "p_device_id": deviceId
      }
    );
  }
}