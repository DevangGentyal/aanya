import 'dart:convert';
import 'dart:io';
import 'package:Aanya/database/user_management.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Function to send the specified image to the API
Future<String> imageDescAPI(File imageFile, String userquery) async {
  await dotenv.load();
  print("Image Description Query: " + userquery);
  var userManagement = Get.find<UserManagement>();
  String description;

  // Read the image file
  final imageBytes = await imageFile.readAsBytes();

  // Encode the image bytes as base64
  String base64Image = base64Encode(imageBytes);

  // API key for accessing the Google Cloud Generative Language API
  String apiKey = dotenv.env['GEMINI_API_KEY'];

  // Define the URL for the API endpoint
  var url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro-vision-latest:generateContent?key=${apiKey}');

  // Construct the JSON payload for the API request
  var requestBody = jsonEncode({
    "contents": [
      {
        "parts": [
          {"text": "$userquery\n\n"},
          {
            "inlineData": {
              "mimeType": "image/webp", // Specify MIME type as JPEG
              "data": base64Image
            }
          }
        ]
      }
    ],
    "generationConfig": {
      "temperature": 0.4,
      "topK": 32,
      "topP": 0.85,
      "maxOutputTokens": 4096,
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
  });

  // Send the HTTP POST request to the API
  var response = await HttpClient().postUrl(url)
    ..headers.set('Content-Type', 'application/json')
    ..write(requestBody);

  // Get the response
  var httpResponse = await response.close();
  var responseBody = await httpResponse.transform(utf8.decoder).join();
  description = extractTextPart(responseBody);
  description = description.replaceAll("*", '');
  print(description);
  final image_path = userManagement.getFileName(imageFile);

  // Updating Activity
  final newactivity = userManagement.createActivity(
      prompt: userquery,
      response: description,
      desc_image_path: image_path,
      gen_image_path: "null");
  userManagement.updateRecentActivites(newactivity);
  userManagement.uploadImage(imageFile);

  return description;
}

String extractTextPart(String responseBody) {
  print(responseBody);
  // Parse the JSON string
  Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

  // Access the candidates field
  List<dynamic> candidates = jsonResponse['candidates'];

  // Access the text part from the first candidate
  String textPart ='';
  try {
    textPart = candidates.isNotEmpty
        ? candidates[0]['content']['parts'][0]['text']
        : '';
  } catch (e) {}
  ;
  return textPart;
}
