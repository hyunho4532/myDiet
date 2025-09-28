import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:mydiet/data/repository/temp_user_r.dart';

class UserController extends GetxController {
  Future<AndroidDeviceInfo> deviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

    return androidDeviceInfo;
  }

  void insertTempUser(String deviceId) {
    TempUserRepository().insert(deviceId);
  }
}