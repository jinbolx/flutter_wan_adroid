import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

const bool inProduction = const bool.fromEnvironment('dart.vm.product');

class PlatformUtils {
  static Future<PackageInfo> getAppPackageInfo() => PackageInfo.fromPlatform();

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await getAppPackageInfo();
    return packageInfo.version;
  }

  static Future<String> getBuildNum() async {
    PackageInfo packageInfo = await getAppPackageInfo();
    return packageInfo.buildNumber;
  }

  static Future getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      return await deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      return await deviceInfoPlugin.iosInfo;
    } else {
      return null;
    }
  }
}
