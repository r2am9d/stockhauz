import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class AppUtil {
  factory AppUtil() => _instance;

  AppUtil._internal() {
    _deviceInfo = DeviceInfoPlugin();
  }

  late final DeviceInfoPlugin _deviceInfo;
  static final AppUtil _instance = AppUtil._internal();

  Future<bool> isAndroidSdk33() async {
    if (!Platform.isAndroid) {
      return false;
    }

    final androidInfo = await _deviceInfo.androidInfo;
    return androidInfo.version.sdkInt == 33;
  }
}
