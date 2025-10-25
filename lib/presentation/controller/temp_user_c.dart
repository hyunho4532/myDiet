import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:mydiet/data/repository/temp_user_r.dart';
import 'package:mydiet/domain/temp_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempUserController extends GetxController {
  var tempUser = <TempUser>[].obs;

  Future<AndroidDeviceInfo> deviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

    return androidDeviceInfo;
  }

  Future<void> fetchTempUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString("uuid")!;

    return TempUserRepository().fetchTempUser(uuid, (data) {
      tempUser.value = data.map((e) => TempUser.fromJson(e)).toList();
    });
  }

  void insertTempUser(String deviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("uuid", deviceId);

    TempUserRepository().insert(deviceId);
  }

  Future<String> validateTempUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString("uuid")!;

    return await TempUserRepository().validate(deviceId);
  }

  Future<int> validateHeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString("uuid")!;

    return await TempUserRepository().validateHeight(deviceId);
  }

  void insertHeight(int height) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString("uuid")!;

    return await TempUserRepository().insertHeight(height, deviceId);
  }
}