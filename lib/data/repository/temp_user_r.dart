import 'package:get/get.dart';
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

  Future<String> validate(String deviceId) async {
    String message = "";

    final result = _client.from("TempUser").select().eq("device_id", deviceId);

    if (result.isNull) {
      message = "사용자를 찾을 수 없습니다!";
    } else {
      message = "현재 게스트 상태입니다!\n로그인을 해주세요";
    }

    return message;
  }

  Future<int> validateHeight(String deviceId) async {
    final response = await _client.rpc(
      "validate_height",
      params: {
        "p_device_id": deviceId
      },
    );

    return response;
  }
}