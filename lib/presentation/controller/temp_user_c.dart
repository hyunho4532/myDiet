import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:mydiet/data/repository/temp_user_r.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempUserController extends GetxController {
  Future<AndroidDeviceInfo> deviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

    return androidDeviceInfo;
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
}