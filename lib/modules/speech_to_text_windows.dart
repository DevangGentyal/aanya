import 'dart:convert';
import 'dart:io';
import 'package:Aanya/common_vars.dart';
import 'package:Aanya/modules/aanya_chat_api.dart';
import 'package:Aanya/modules/opening_apps.dart';
import 'package:Aanya/modules/request_classifier_api.dart';
import 'package:Aanya/modules/text_to_speech.dart';
import 'package:Aanya/pages/desktop_pages/home-page.dart';
import 'package:deepgram_speech_to_text/deepgram_speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

AudioRecorder recorder = AudioRecorder();

@override
init() {
  initTTS();
}
Future<void> startWindowsListening(CommonVariables commonVars) async {
  isRecording = true;
  player.stop();
  print("Start Listening called");
  commonVars.setReponseRecieved(false);
  commonVars.updateDisplayResponse('');
  commonVars.updateRecognizedWords('');
  await startRecording(commonVars);
}

Future<void> stopWindowsListening(
    BuildContext context, CommonVariables commonVars) async {
  isRecording = false;
  final result = await stopRecording();
  if (result != "null" || result != null) {
    String recognizedWords = await transcribeSpeech(commonVars);
    commonVars.updateRecognizedWords(recognizedWords);
    commonVars.updateAanyaStatus("Processing");

    print(commonVars.recognizedWords);
    // Execute both API calls concurrently
    var apiResults = await Future.wait([
      aanyaChatAPI(commonVars.recognizedWords), // Normal API call
      reqClassifierAPI(commonVars.recognizedWords, commonVars, context),
      // Classifier API call
    ]);

    // Extract the responses from the API results
    commonVars.updateNormalResponse(apiResults[0]);
    commonVars.updateClassifierResponse(apiResults[1]);
    commonVars.setReponseRecieved(true);

    // Check the condition after both responses are received
    if (commonVars.classifierResponse == "other") {
      commonVars.updateDisplayResponse(commonVars.normalResponse);
      // Speaking back the answer
      desktopTTS(commonVars.normalResponse);

      // Updating Activity
      final newactivity = user_management.createActivity(
          prompt: commonVars.recognizedWords,
          response: commonVars.normalResponse,
          desc_image_path: 'null',gen_image_path: 'null');
      await user_management.updateRecentActivites(newactivity);
    } else {
      commonVars.updateDisplayResponse(commonVars.classifierResponse);
      // Speaking back the answer
      desktopTTS(commonVars.classifierResponse);
    }
  }
}

Future<void> startRecording(CommonVariables commonVars) async {
  recorder = AudioRecorder();
  if (await recorder.hasPermission()) {
    // Play Start sound
    await playLocalFile("assets/start_record_beep.mp3");
    // Configure recording settings (optional)
    final config = RecordConfig(
      encoder: AudioEncoder.wav, // Ensure WAV format
      bitRate: 16000, // Standard audio bitrate
    );
    commonVars.updateAanyaStatus("Listening");
    try {
      await recorder.start(config, path: 'assets/user_speech.wav');
      isRecording = true;
    } catch (e) {
      // Handle recording errors gracefully
      print("Error while recording: $e");
    }
  } else {
    // Request microphone permission if not granted
    print("Enable Mic");
  }
}

Future<String?> stopRecording() async {
  if (isRecording) {
    // Play Stop sound
    final path = await recorder.stop(); // Get the actual recording path
    isRecording = false; // Update filePath after successful recording
    await playLocalFile("assets/stop_record_beep.mp3");
    return (path);
  }
  recorder.dispose();
  return ("null");
}

Future<String> transcribeSpeech(CommonVariables commonVars) async {
  print("Speech to Text Called");
  commonVars.updateAanyaStatus("Recognizing");
  Deepgram deepgram = Deepgram(
    "ddd473d0e3ec8fba198733fb812c3de6f50e3380",
  );
  File audioFile = File("assets/user_speech.wav");
  String response = await deepgram.transcribeFromFile(audioFile);
  Map<String, dynamic> jsonResponse = jsonDecode(response);

  String transcript =
      jsonResponse['results']['channels'][0]['alternatives'][0]['transcript'];
  print("STT: " + response);
  return transcript;
}

