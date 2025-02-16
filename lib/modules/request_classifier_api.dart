import 'dart:convert';
import 'dart:io';
import 'package:Aanya/database/user_management.dart';
import 'package:Aanya/modules/device_request_sender.dart';
import 'package:Aanya/modules/image_gen_api.dart';
import 'package:Aanya/modules/opening_apps.dart';
import 'package:Aanya/modules/text_to_speech.dart';
import 'package:Aanya/utils/get_device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:Aanya/common_vars.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> reqClassifierAPI(
    String query, CommonVariables commonVars, BuildContext context) async {
  print("requestClassifier Called");
  await dotenv.load();
  final String user_query = query;
  // Replace YOUR_API_KEY with your actual API key
  final String API_KEY = dotenv.env['GEMINI_API_KEY'];
  // Define the request body
  final Map<String, dynamic> requestBody = {
    "contents": [
      {
        "parts": [
          {"text": "input: Draw a picture of a cat."},
          {"text": "output: image_generation"},
          {"text": "input: Can you create an image of a landscape?"},
          {"text": "output: image_generation"},
          {"text": "input: Generate a cool image please."},
          {"text": "output: image_generation"},
          {"text": "input: Draw a cool image please."},
          {"text": "output: image_generation"},
          {"text": "input: Open the camera app."},
          {"text": "output: open_camera"},
          {"text": "input: Can you launch the music player?"},
          {"text": "output: open_spotify"},
          {"text": "input: Bring up the settings menu."},
          {"text": "output: open_settings"},
          {"text": "input: Show me my photos."},
          {"text": "output: open_Photos"},
          {"text": "input: Switch to my phone."},
          {"text": "output: switch_to_Phone"},
          {"text": "input: Show me what's on my tablet."},
          {"text": "output: switch_to_Tablet"},
          {"text": "input: Come on my Desktop"},
          {"text": "output: switch_to_Desktop"},
          {"text": "input: Jump to Laptop"},
          {"text": "output: switch_to_Laptop"},
          {"text": "input: What's in the picture?"},
          {"text": "output: image_description"},
          {"text": "input: Describe the image for me."},
          {"text": "output: image_description"},
          {"text": "input: Can you tell me what objects are in the photo?"},
          {"text": "output: image_description"},
          {"text": "input: Let's dance!"},
          {"text": "output: dancing"},
          {"text": "input: Do some moves"},
          {"text": "output: dancing"},
          {"text": "input: Can you make me dance?"},
          {"text": "output: dancing"},
          {"text": "input: open Youtube and search for CarryMinati"},
          {"text": "output: open_youtube:CarryMinati"},
          {"text": "input: play video of Smurfs"},
          {"text": "output: open_youtube:Smurfs"},
          {"text": "input: play TMKOC video"},
          {"text": "output: open_youtube:TMKOC"},
          {"text": "input: want to see some thing new on youtube"},
          {"text": "output: open_youtube:New"},
          {"text": "input: play Despacito"},
          {"text": "output: open_spotify:despacito"},
          {"text": "input: play Kasur"},
          {"text": "output: open_spotify:Kasur"},
          {"text": "input: play Luka Chippi by Seedhe Maut"},
          {"text": "output: open_spotify:Luka Chippi by Seedhe Maut"},
          {"text": "input: Basic General Knowledge"},
          {"text": "output: none"},
          {"text": "input: " + user_query},
          {"text": "output: "}
        ]
      }
    ],
    "generationConfig": {
      "temperature": 0.9,
      "topK": 1,
      "topP": 1,
      "maxOutputTokens": 2048,
      "stopSequences": []
    },
    "safetySettings": [
      {
        "category": "HARM_CATEGORY_HARASSMENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      },
      {
        "category": "HARM_CATEGORY_HATE_SPEECH",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      },
      {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      },
      {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      }
    ]
  };

  // Make the API request
  final response = await http.post(
    Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=$API_KEY"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestBody),
  );

  // Check if the request was successful
  if (response.statusCode == 200) {
    // Handle the response
    var parsedJson = json.decode(response.body);
    String formatted_resp = parsedJson['candidates'][0]['content']['parts']
        .map((part) => part['text'])
        .join('\n');
    print('Classifier API result: ' + formatted_resp);
    return proccess_classification(
        formatted_resp, user_query, commonVars, context);
  } else {
    // Handle errors
    print('Request failed with status: ${response.statusCode}');
    return 'other';
  }
}

Future<String> proccess_classification(String formatted_resp, String user_query,
    CommonVariables commonVars, BuildContext context) async {
  final userManagement = Get.find<UserManagement>();
  String response = "";

  // Image Generation command
  if (formatted_resp.contains("image_generation")) {
    if (Platform.isAndroid || Platform.isIOS) {
      flutterTts.speak("Okay! lets Generate Images you requested.");
      commonVars.updatePageName("image-gen");
      commonVars.updateGeneratedImage(await imageGenAPI(user_query));
      response = "Its Done, checkout the Images";
    } else {
      desktopTTS("Okay! lets Generate Images you requested.");
      commonVars.updatePageName("image-gen");
      commonVars.updateGeneratedImage(await imageGenAPI(user_query));
      response = "Its Done, checkout the Images";
    }
  }
  // Image Description command
  else if (formatted_resp.contains("image_description")) {
    response = "Sure! Upload the Image and wait for a while";
    commonVars.updatePageName("image-desc");
  }
  // Switching Device command
  else if (formatted_resp.contains("switch_to_")) {
    String deviceName = formatted_resp.split("switch_to_")[1];
    final userdevices = await userManagement.getUserDevices();

    for (var device in userdevices) {
      // First Check if user requested to switch on same device
      if (device['device_id'] == await getCurrentDeviceId()) {
        if (deviceName
            .toLowerCase()
            .contains(device['device_name'].toString().toLowerCase())) {
          response = "Already on the Device";
          break;
        }
      }
      if (device['device_name']
          .toString()
          .toLowerCase()
          .contains(deviceName.toLowerCase())) {
        print(
            "Sending request to  ${device['device_name']}, ${device['device_ip']}");
        String result = await sendRequestToDevice(
            device['device_ip'], '12345', "switching-req");
        if (result == "accepted") {
          response = "Okay! Switching to $deviceName";
          await Future.delayed(const Duration(seconds: 2));
          await userManagement.updateUserInfo(
              'active_device', device['device_id']);
          Navigator.pushNamed(context, '/loading_scene');
        } else {
          response = result;
        }
        break;
      } else {
        response = "The device named $deviceName not found.";
      }
    }
    // Updating Activity
    final newactivity = userManagement.createActivity(
        prompt: user_query,
        response: response,
        desc_image_path: 'null',
        gen_image_path: 'null');
    userManagement.updateRecentActivites(newactivity);
  }
  // Opning Apps command
  else if (formatted_resp.contains("open_")) {
    String appname = '';
    String data = '';
    try {
      appname = formatted_resp.split("_")[1];
      data = formatted_resp.substring(formatted_resp.indexOf(':') + 1).trim();
      appname = appname.substring(0, appname.indexOf(':'));
      appname = appname.toLowerCase();
    } catch (e) {}
    ;
    response = await openApp(appname, user_query, data);
  }
  // Other (Chat)
  else {
    response = "other";
    commonVars.updatePageName("talk-to-aanya");
  }
  return response;
}
