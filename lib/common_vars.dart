// Stores Common variables which are used across the app
import 'dart:io';

import 'package:flutter/material.dart';

// Constants
double baseWidth = 0.0;
double baseHeight = 0.0;
double fem = 0.0;
double width_fem = 0.0;
double height_fem = 0.0;
double ffem = 0.0;
double fwidth_fem = 0.0;
double screen_width = 0.0;
double screen_height = 0.0;
late BuildContext commonContext;
void setConstants(BuildContext context, bool isDesktop) {
  if (isDesktop) {
    baseWidth = 1440;
    baseHeight = 900;
    width_fem = MediaQuery.of(context).size.width / baseWidth;
    height_fem = MediaQuery.of(context).size.height / baseHeight;
    fem = width_fem;
    fwidth_fem = width_fem * 0.97;
    ffem = fwidth_fem;
    screen_width = MediaQuery.of(context).size.width;
    screen_height = MediaQuery.of(context).size.height;
    // Function to get the device's IP address
  } else {
    baseWidth = 360;
    fem = MediaQuery.of(context).size.width / baseWidth;
    ffem = fem * 0.97;
    screen_width = MediaQuery.of(context).size.width;
    screen_height = MediaQuery.of(context).size.height;
  }
  commonContext = context;
}

// Variavles
class CommonVariables extends ChangeNotifier {
  String recognizedWords = 'Tap the mic to Say Something';
  String normalResponse = '';
  String classifierResponse = '';
  String displayResponse = '';
  bool responseRecived = false;
  String pageName = 'home-scene';
  String aanyaStatus = 'Idle';

  // Variable to hold the generated image file and ImageSectionVisibility
  File? generatedImage;
  bool showImagesSection = true;

  // Database
  String email = "";
  String name = "Root";
  String age = "";
  String phone_no = "";
  String res = '';
  late List<Map<String, dynamic>> devices;

  void updateName(String newValue) {
    name = newValue;
    notifyListeners();
  }

  void updateEmail(String newValue) {
    email = newValue;
    notifyListeners();
  }

  void updateAge(String newValue) {
    age = newValue;
    notifyListeners();
  }

  void updatePhone_no(String newValue) {
    phone_no = newValue;
    notifyListeners();
  }

  void updateRecognizedWords(String newValue) {
    recognizedWords = newValue;
    notifyListeners();
  }

  void updateNormalResponse(String newValue) {
    normalResponse = newValue;
    notifyListeners();
  }

  void updateClassifierResponse(String newValue) {
    classifierResponse = newValue;
    notifyListeners();
  }

  void updateDisplayResponse(String newValue) {
    displayResponse = newValue;
    notifyListeners();
  }

  void setReponseRecieved(bool newValue) {
    responseRecived = newValue;
    notifyListeners();
  }

  void updatePageName(String newValue) {
    pageName = newValue;
    notifyListeners();
  }

  void updateAanyaStatus(String newValue) {
    aanyaStatus = newValue;
    notifyListeners();
  }

  void updateGeneratedImage(File? newValue) {
    generatedImage = newValue;
    notifyListeners();
  }
  void updateShowImageSection(bool newValue) {
    showImagesSection = newValue;
    notifyListeners();
  }
}
