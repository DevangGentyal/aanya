import 'dart:io';

import 'package:Aanya/common_vars.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flowery_tts/flowery_tts.dart';
import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts = FlutterTts();

void initTTS() async {
  await flutterTts.setLanguage("en-IN");
  await flutterTts.setPitch(1);
  await flutterTts.setSpeechRate(0.5);

  flutterTts.setVoice({"name": "en-in-x-enc-network", "locale": "en-IN"});
}

// For Desktop
AudioPlayer player = AudioPlayer();
const flowery = Flowery();
final commVars = CommonVariables();

void desktopTTS(String text) async {
  await player.stop(); // Stop the player if it's playing
  player.release(); // Release resources associated with the player
  final audio = await flowery.tts(text: text, voice: 'Anushri');
  final audiofile = await File('assets/response.mp3')
    ..writeAsBytesSync(audio, mode: FileMode.write);
  await playLocalFile(audiofile.path);
  await deleteFile(audiofile); // Delete the file after playback
}

Future<void> playLocalFile(String path) async {
  player = AudioPlayer();
  await player.play(DeviceFileSource(path));
  player.onPlayerComplete.listen((event) { 
    commVars.updateAanyaStatus("Idle");
    player.release(); // Release resources associated with the player
  });
}
Future<void> deleteFile(File file) async {
  try {
    await file.delete();
    print('File deleted successfully');
  } catch (e) {
    print('Error deleting file: $e');
  }
}