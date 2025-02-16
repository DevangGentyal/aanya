import 'dart:async';
import 'package:http/http.dart' as http;

Future<String> sendRequestToDevice(String ipAddress, String port, String message) async {
  try {
    final response = await http.post(
      Uri.parse('http://$ipAddress:$port'),
      body: message,
      headers: {
        'Content-Type': 'text/plain', 
      },
    );
    if (response.statusCode == 200) {
      return response.body; 
    } else {
      return "Unable to send Request. Check if the app is open on requested Device";
    }
  } catch (e) {
    return "Unable to send Request. Check if the app is open on requested Device";
  }
}