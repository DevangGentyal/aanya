import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

// Map to keep track of whether a server is running for each IP and port combination
final Map<String, bool> serverStatus = {};
late BuildContext reciver_context;
late BuildContext ancestor_context;

Future<void> listenForDeviceRequests(
  String ip,
  int port,
) async {
  // Check if a server is already running for the given IP and port
  if (serverStatus['$ip:$port'] == true) {
    print('Server is already running on $ip:$port');
    return;
  }

  // If server is not running, start a new one
  print("Started Listening for Device Requests on ${ip}, ${port}");
  try {
    final server = await HttpServer.bind(ip, port);
    serverStatus['$ip:$port'] = true; // Update server status
    print('Server running on port $port');

    await for (var request in server) {
      handleRequest(
        request,
      );
    }
  } catch (e) {}
}

void handleRequest(
  HttpRequest request,
) async {
  try {
    if (request.method == 'POST') {
      final requestData = await utf8.decoder.bind(request).toList();
      final message = requestData.join();
      print('Received message: $message');
      if (message == "switching-req") {
        // Process the received message as needed
        request.response
          ..statusCode = HttpStatus.ok
          ..write('accepted')
          ..close();
        print('Accepted Switching');
        await doNavigation();
      } else {
        //
        request.response
          ..statusCode = HttpStatus.ok
          ..write('declined')
          ..close();
      }
      return;
    } else {
      request.response
        ..statusCode = HttpStatus.methodNotAllowed
        ..write('Unsupported request method: ${request.method}')
        ..close();
    }
  } catch (e) {
    try{
    print('Error handling request: $e');
    request.response
      ..statusCode = HttpStatus.internalServerError
      ..write('Internal server error')
      ..close();
      }catch(e){
        
      }
  }
}

// Function to stop the server for a given IP and port
Future<void> stopServer(String ip, int port) async {
  if (serverStatus['$ip:$port'] == true) {
    serverStatus['$ip:$port'] = false; // Update server status
    print('Stopping server on $ip:$port');
  }
}

Future<void> doNavigation() async {
  Navigator.pushReplacementNamed(reciver_context, '/home');
}
