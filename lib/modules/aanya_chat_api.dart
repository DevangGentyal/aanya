import 'dart:convert';
import 'package:Aanya/database/user_management.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> aanyaChatAPI(String query) async {
  await dotenv.load();
  var userManagement = Get.find<UserManagement>();
  List<Map<String, Object>> convo = [
    {
      "role": "user",
      "parts": [
        {"text": query}
      ]
    }
  ];

  // Get recent activity
  List<Map<String, dynamic>> recent_activites =
      await userManagement.fetchRecentActivities() ?? [];
  List<Map<String, Object>> request_activity = [];

  int startIdx = recent_activites.length > 5 ? recent_activites.length - 5 : 0;
  // Conversion to request body Map
  for (var item in recent_activites.sublist(startIdx)) {
    // Create user part
    Map<String, Object> userPart = {
      "role": "user",
      "parts": [
        {"text": "${item["prompt"]}"}
      ]
    };

    // Create model part
    Map<String, Object> modelPart = {
      "role": "model",
      "parts": [
        {"text": "${item["response"]}"}
      ]
    };

    // Add user and model parts to the new list
    request_activity.add(userPart);
    request_activity.add(modelPart);
  }

  // Appending request activity to convo
  convo.insertAll(0, request_activity);

  if (query.trim() == '') {
    return "Not Recognized what you said, Please try again";
  }
  // final String user_query = query;
  final String API_KEY = dotenv.env['GEMINI_API_KEY']; // Replace YOUR_API_KEY with your actual API key

  final Map<String, dynamic> requestBody = {
    "contents": [
      {
        "role": "user",
        "parts": [
          {
            "text":
                "Act as You are Anya a Dynamic A.I. companion.You were developed by Devang Gentyal, Shouryan Bharote and Chirag Patil students of GPP. You can do tasks such as Assistance to in general qna, solve coding issues, play music from spotify, open Yotube, Netflix and Email, Generate stunning images, Describe images, switch from one device to another, Language Translation, you are a Multiplatformed model which also supports Multiple Languages. Answer to users in a short, soft, sweet and precise way. "
          }
        ]
      },
      {
        "role": "model",
        "parts": [
          {
            "text":
                "Hello! I am Anya, your Dynamic A.I. companion. I am here to assist you with a wide range of tasks."
          }
        ]
      },
      {
        "role": "user",
        "parts": [
          {
            "text":
                "User Details:- UserName: ${userManagement.name}, Email: ${userManagement.email}, Gender: ${userManagement.gender},Age: ${userManagement.age},Phone: ${userManagement.phone_no},Interests: ${userManagement.interests}, Location:${userManagement.location}.The above are user details. Give personalized response. also use location data if needed. Also suggest clothing based on gender"
          }
        ]
      },
      {
        "role": "model",
        "parts": [
          {
            "text":
                "Okay I will give personalized responses with based on your gender, interests, age, location. Also i will suggest clothing based on your Gender"
          }
        ]
      },
    ],
    "generationConfig": {
      "temperature": 0.9,
      "topK": 1,
      "topP": 1,
      "maxOutputTokens": 2048,
      "stopSequences": []
    },
    "safetySettings": [
      {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_ONLY_HIGH"},
      {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_ONLY_HIGH"},
      {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "threshold": "BLOCK_ONLY_HIGH"
      },
      {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "threshold": "BLOCK_ONLY_HIGH"
      }
    ]
  };

  // Adding Convo history to body request
  requestBody['contents'].addAll(convo);

  // Wait for response
  final response = await http.post(
    Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=$API_KEY"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestBody),
  );
  print(requestBody);
  // If Successful response
  if (response.statusCode == 200) {
    try {
      // Getting and formating response
      var parsedJson = json.decode(response.body);
      String formatted_resp = parsedJson['candidates'][0]['content']['parts']
          .map((part) => part['text'])
          .join('\n');
      formatted_resp = formatted_resp.replaceAll("*", '');

      return formatted_resp;
    } catch (Exception) {
      print(Exception);
      return "Something went wrong. Please try again";
    }
  } else {
    return 'Failed to load response';
  }
}
