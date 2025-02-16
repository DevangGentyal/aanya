// Initial Checkings
import 'package:Aanya/database/user_management.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/utils/get_device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

Future<String> initChecks(BuildContext context) async {
  // Starting UserManagement
  await Get.putAsync<UserManagement>(() async => UserManagement());
  UserManagement userManagement = Get.find<UserManagement>();
  await userManagement.fetchUserData();

  List<dynamic> devices = await userManagement.getUserDevices();
  String active_device_id =
      await userManagement.getUserInfo('active_device') ?? '';
  String current_device_ip = await getCurrentDeviceIp();
  String current_device_id = await getCurrentDeviceId();

  bool new_login = false;
  bool first_login = false;
  String device_name = '';

  // First Check - if the Maximum device capacity reached
  if (devices.length > 5) {
    Navigator.pushReplacementNamed(context, '/device-checking',
        arguments: {'scene': 'full-devices', 'device-name': ''});
    return 'full-devices';
  }

  // Second Check - if the Device IP is present in DB
  if (devices.length > 0) {
    // Looping Through devices
    for (var device in devices) {
      if (device["device_id"] == current_device_id) {
        device_name = device['device_name'];
        new_login = false;
        break;
      } else {
        new_login = true;
      }
    }
  } else {
    first_login = true;
    new_login = true;
  }

  // Third Check - if new login or existing also first time login check
  if (first_login) {
    Navigator.pushReplacementNamed(context, '/device-checking',
        arguments: {'scene': 'first-login', 'device-name': ''});
    return "first-login";
  } else if (new_login) {
    Navigator.pushReplacementNamed(context, '/device-checking',
        arguments: {'scene': 'new-login', 'device-name': ''});
    return "new-login";
  } else {
    // First update latest IP of user device
    List<dynamic> updatedDevices = [];
    for (var device in devices) {
      final Map<String, dynamic> newDevice;
      if (device['device_id'] != current_device_id) {
        newDevice = {
          "device_id": device['device_id'],
          "device_ip": device['device_ip'],
          "device_name": device['device_name'],
          "last_active": DateTime.now().toString(),
        };
      } else {
        newDevice = {
          "device_id": device['device_id'],
          "device_ip": current_device_ip,
          "device_name": device['device_name'],
          "last_active": DateTime.now().toString(),
        };
      }
      updatedDevices.add(newDevice);
    }
    await userManagement.updateDevices(updatedDevices);

    listenForDeviceRequests(
      current_device_ip,
      12345,
    );
    // Fourth Check - if the there is no active device
    if ((active_device_id == "none") ||
        active_device_id == '' ||
        (active_device_id == current_device_id)) {
      Navigator.pushNamed(context, '/home');
      return "success";
    } else {
      Navigator.pushReplacementNamed(context, '/device-checking',
          arguments: {'scene': 'waiting', 'device-name': device_name});
      return "waiting";
    }
  }
}

Future<String> StartService() async {
  await Get.putAsync<UserManagement>(() async => UserManagement());
  UserManagement userManagement = Get.find<UserManagement>();
  await userManagement.fetchUserData();
  return "started";
}
