import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getCurrentDeviceIp() async {
  String current_device_ip = 'null';
  try {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4) {
          current_device_ip = addr.address;
        }
      }
    }
    return current_device_ip;
  } catch (e) {
    print('Error getting IP address: $e');
    return "null";
  }
}

Future<String> getCurrentDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }
  else if(Platform.isIOS){
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor!;
  }
  else if(Platform.isWindows){
    WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
    return windowsInfo.deviceId;
  }
  else if(Platform.isMacOS){
    MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
    return macOsInfo.systemGUID!;
  }
  return "";
}
