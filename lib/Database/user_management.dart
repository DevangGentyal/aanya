import 'package:Aanya/database/supabase_service.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class UserManagement extends GetxService {
  final RxString id = RxString('');
  final String table = "users";
  final String bucket = "user_recent_activities";
  final String imageurl =
      "https://zfikjgmnxxltrkboxfuk.supabase.co/storage/v1/object/public/user_recent_activities/";

  final RxString email = RxString('');
  final RxString name = RxString('');
  final RxString age = RxString('');
  final RxString gender = RxString('Male');
  final RxString phone_no = RxString('');
  final RxString interests = RxString('');
  final RxString location = RxString('');

  final RxList<dynamic> devices = RxList([]);
  final RxList<Map<String, dynamic>> recent_activites =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // Fetch user data during app initialization
  }

  Future<void> fetchUserData() async {
    try {
      id.value = await getUserId() ?? "";
      name.value = await getUserInfo('name') ?? "Root";
      email.value = await getUserInfo('email') ?? "";
      age.value = await getUserInfo('age') ?? "";
      phone_no.value = await getUserInfo('phone_no') ?? "";
      devices.value = await getUserDevices();
      gender.value = await getUserInfo("gender") ?? "";
      interests.value = await getUserInfo("interests") ?? "";
      location.value = await getUserInfo("location") ?? "";
      recent_activites.value =
          await fetchRecentActivities() ?? <Map<String, dynamic>>[];
      print("currently ${name} is logged in");
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<String?> getUserId() async {
    final response = await SupabaseService.supabaseClient.auth.currentUser?.id;
    return response;
  }

  Future<String?> getUserInfo(String field) async {
    try {
      final response = await SupabaseService.supabaseClient
          .from(table)
          .select(field)
          .eq('id', id);

      // ignore: unnecessary_null_comparison
      if (response != null && response.length > 0) {
        return response[0][field] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching $field: $e');
      return null;
    }
  }

  Future<void> updateUserInfo(String field, String value) async {
    try {
      await SupabaseService.supabaseClient
          .from('users')
          .update({field: value}).eq('id', id);
      // Update the local Rx variable
      switch (field) {
        case 'name':
          name.value = value;
          break;
        case 'email':
          email.value = value;
          break;
        case 'age':
          age.value = value;
          break;
        case 'phone_no':
          phone_no.value = value;
          break;
        default:
          // Handle other fields if necessary
          break;
      }
    } catch (e) {
      print('Error updating user info: $e');
      rethrow; // Re-throw the error to handle it in the calling code
    }
  }

  String getFileName(File imageFile) {
    return path.basename(imageFile.path);
  }

  Future<String> uploadImage(File imageFile) async {
    final fileName = path.basename(imageFile.path);
    try {
      await SupabaseService.supabaseClient.storage
          .from(bucket)
          .upload('${id}/${fileName}', imageFile);
      print('Image uploaded successfully');
      return "success";
    } catch (e) {
      print('Error uploading image: ${e}');
      return "null";
    }
  }

  String getImageURL(String filename) {
    return "${imageurl}${id}/${filename}";
  }

  Future<File> downloadImage(String fileName) async {
    try {
      final response = await SupabaseService.supabaseClient.storage
          .from(bucket)
          .download('${id}/${fileName}');
      final file = File('path/to/save/image/${fileName}');
      await file.writeAsBytes(response);
      print('Image downloaded successfully');
      return file;
    } catch (e) {
      print('Error downloading image: $e');
      rethrow;
    }
  }

  Future<String> deleteImage(String fileName) async {
    try {
      await SupabaseService.supabaseClient.storage
          .from(bucket)
          .remove(['${id}/${fileName}']);
      return "success";
    } catch (e) {
      print('Error deleting images from storage: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchRecentActivities() async {
    try {
      final response = await SupabaseService.supabaseClient
          .from(table)
          .select('recent_activites')
          .eq('id', id);
      if (response[0]['recent_activites'] == null) {
        return [];
      }

      // Get the device data from the response
      final List<dynamic> recent_activites_data =
          response[0]['recent_activites'];

      List<Map<String, dynamic>> recent_activites = [];
      for (var entry in recent_activites_data) {
        recent_activites.add({
          'prompt': entry['prompt'],
          'response': entry['response'],
          'desc_image_path': entry['desc_image_path'],
          'gen_image_path': entry['gen_image_path'],
          'created_at': entry['created_at'],
        });
      }
      return recent_activites;
    } catch (e) {
      print("Error fetching activites: ${e}");
      rethrow;
    }
  }

  Map<String, String> createActivity({
    required String prompt,
    required String response,
    required String desc_image_path,
    required String gen_image_path,
  }) {
    final newactivity = {
      'prompt': prompt,
      'response': response,
      'desc_image_path': desc_image_path,
      'gen_image_path': gen_image_path,
    };
    print("Activity completed: ${newactivity}");
    return newactivity;
  }

  Future<void> updateRecentActivites(newactivity) async {
    // // Add the new activity to the beginning of the list
    recent_activites.add(newactivity);

    // If the list exceeds 10 activities, remove the oldest one
    if (recent_activites.length > 10) {
      print("Poping an activity");
      if (recent_activites[0]['desc_image_path'] != "null") {
        deleteImage(recent_activites[0]['desc_image_path']);
      }
      if (recent_activites[0]['gen_image_path'] != "null") {
        deleteImage(recent_activites[0]['gen_image_path']);
      }
      recent_activites.removeAt(0);
    }
    await syncActivitiesWithDatabase(recent_activites);
  }

  Future<void> syncActivitiesWithDatabase(
      List<Map<String, dynamic>> recent_activites) async {
    try {
      // Update the activities in the database
      final response = await SupabaseService.supabaseClient
          .from(table)
          .update({"recent_activites": recent_activites}).eq('id', id);

      if (response.error != null) {
        throw response.error!.message;
      }
    } catch (e) {
      print('Error updating activities in the database: $e');
      // rethrow;
    }
  }

  Future<List<dynamic>> getUserDevices() async {
    try {
      final response = await SupabaseService.supabaseClient
          .from('users')
          .select('devices')
          .eq('id', id);

      //Check if there are no Devices in database yet
      if (response[0]['devices'] == null) {
        return [];
      }
      // Get the device data from the response
      final List<dynamic> devices = response[0]['devices'];
      return devices;
    } catch (e) {
      print('Error fetching devices: $e');
      return [];
    }
  }

  Future<void> addDevice(
    String deviceName,
    String deviceIP,
    String deviceID,
  ) async {
    try {
      // Construct the new device object
      final Map<String, dynamic> newDevice = {
        "device_id": deviceID,
        "device_ip": deviceIP,
        "device_name": deviceName,
        "last_active": DateTime.now().toString(),
      };
      final previousdevices = await getUserDevices();
      // Update the local device array by appending the new device
      previousdevices.add(newDevice);

      // Update the users table to append the new device to the devices array
      await SupabaseService.supabaseClient
          .from('users')
          .update({'devices': previousdevices}).eq('id', id);
    } catch (e) {
      print('Error adding device: $e');
    }
  }

  Future<void> updateDevices(List<dynamic> newDeviceList) async {
    print("update user devices called");
    await SupabaseService.supabaseClient
        .from('users')
        .update({'devices': newDeviceList}).eq('id', id);
  }
}
