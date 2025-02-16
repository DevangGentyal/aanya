import 'dart:async';
import 'package:Aanya/database/user_management.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

var user_management = Get.find<UserManagement>();
String data = '';
 Map appPackageUrls = {
    'spotify': 'spotify:',
    'chrome': 'googlechrome://',
    'youtube': 'https://www.youtube.com/results?search_query=',
    'Youtube': 'https://www.youtube.com/results?search_query=',
    'YouTube': 'https://www.youtube.com/results?search_query=',
    'whatsapp': 'whatsapp://send?phone=+91'+user_management.phone_no.value,
    'hotstar': 'https://www.hotstar.com/in/home?ref=%2Fus',
    'facebook': 'https://www.facebook.com/',
    'instagram': 'https://www.instagram.com/',
  };
  
Future<String> openApp(String appname,String user_query,String searchdata) async {
  data = searchdata;
  String response = '';
  print("Appname:" +appname+" , Data: "+data);
  if (appPackageUrls.containsKey(appname)) {
    try {
      if (!await launchUrl(Uri.parse(appPackageUrls[appname]+data),
          mode: LaunchMode.externalApplication)) {
        throw 'Could not launch ';
      }
    } catch (e) {
      print(e);
    }
    response = "Opening " + appname;
  } else {
    response =
        "Sorry, I don't have the App Access you requested";
  }
  // Updating Activity
  final newactivity = user_management.createActivity(
      prompt: user_query, response: response, desc_image_path: 'null',gen_image_path: 'null');
  user_management.updateRecentActivites(newactivity);
  return response;
}
