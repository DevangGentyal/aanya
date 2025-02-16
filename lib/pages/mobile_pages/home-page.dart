import 'dart:ui';
import 'package:Aanya/database/user_management.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/modules/opening_apps.dart';
import 'package:Aanya/pages/mobile_pages/app-settings.dart';
import 'package:Aanya/pages/mobile_pages/manage-devices.dart';
import 'package:Aanya/pages/mobile_pages/user-profile-page.dart';
import 'package:Aanya/utils/get_device_info.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:Aanya/pages/mobile_pages/home-scene.dart';
import 'package:Aanya/pages/mobile_pages/settings-page.dart';
import 'package:Aanya/pages/mobile_pages/talk-to-aanya.dart';
import 'package:Aanya/pages/mobile_pages/image-generation.dart';
import 'package:Aanya/pages/mobile_pages/image-description.dart';
import 'package:Aanya/modules/request_classifier_api.dart';
import 'package:Aanya/modules/aanya_chat_api.dart';
import 'package:Aanya/modules/text_to_speech.dart';
import 'package:Aanya/common_vars.dart';
import 'package:provider/provider.dart';

// Global Variable
String recognizedWords = '';
String normal_response = '';
String classifier_response = '';
ScrollController scrollController = ScrollController();

class MobileHomePage extends StatefulWidget {
  @override
  _MobileHomePageState createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  bool isBottomSheetVisible = false;
  bool micButtonClicked = false;
  stt.SpeechToText _speech = stt.SpeechToText();
  var userManagement = Get.find<UserManagement>();

  @override
  void initState() {
    super.initState();
    _speech.initialize();
    initTTS();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Get User Loaction
    bool hasPermission = await _handleLocationPermission();
    if (hasPermission) {
      // Get location in Longitude Latitude
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placeMarks = [];
      String currentAddress = '';
      try {
        placeMarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark place = placeMarks[0];
        currentAddress =
            'Postal Code: ${place.postalCode}, SubAdministrative Area: ${place.subAdministrativeArea},SubLocality: ${place.subLocality}, Street: ${place.street}';
      } catch (e) {}
      // Updating user location in DB
      userManagement.updateUserInfo('location', currentAddress);
    }
    // Set Active Device
    await user_management.updateUserInfo(
        'active_device', await getCurrentDeviceId());
    // Finally Fetch New Data
    await userManagement.fetchUserData();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    CommonVariables commonVars = Provider.of<CommonVariables>(context);
    String pageName = commonVars.pageName;
    reciver_context = context;

    // Methods for Speech to Text
    void startListening() {
      flutterTts.stop();
      commonVars.updateAanyaStatus("Listening");
      print("Start Listening called");
      commonVars.setReponseRecieved(false);
      commonVars.updateDisplayResponse('');
      commonVars.updateRecognizedWords('');
      _speech.listen(
        listenFor: Duration(milliseconds: 10000),
        pauseFor: Duration(milliseconds: 10000),
        onResult: (result) async {
          // Updating Recognized words in common variables file
          commonVars.updateRecognizedWords(result.recognizedWords);
          // Check if the voice recognition is successful
          if (result.finalResult) {
            commonVars.updateAanyaStatus("Processing");
            micButtonClicked = false;
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
              flutterTts.speak(commonVars.normalResponse);

              // Updating Activity
              final newactivity = userManagement.createActivity(
                  prompt: commonVars.recognizedWords,
                  response: commonVars.normalResponse,
                  desc_image_path: 'null',
                  gen_image_path: 'null');
              await userManagement.updateRecentActivites(newactivity);
            } else {
              commonVars.updateDisplayResponse(commonVars.classifierResponse);
              flutterTts.speak(commonVars.classifierResponse);
            }
          }
        },
      );
    }

    // Function to stop Speech to Text listening
    void stopListening() {
      _speech.stop();
    }

    flutterTts.startHandler = () {
      commonVars.updateAanyaStatus("Speaking");
    };
    flutterTts.completionHandler = () {
      commonVars.updateAanyaStatus("Idle");
    };

    // Method for building Scenes on Home Page
    Widget buildPageContent(String pageName) {
      if (pageName == "home-scene") {
        return MobileHomeScene();
      } else if (pageName == "talk-to-aanya") {
        return MobileTalktoAanya();
      } else if (pageName == "image-gen") {
        return MobileImageGeneration();
      } else if (pageName == "image-desc") {
        return MobileImageDescription();
      } else if (pageName == "settings") {
        return MobileSettings();
      } else if (pageName == "profile") {
        return MobileUserProfile();
      } else if (pageName == "manage-devices") {
        return MobileManageDevices();
      } else if (pageName == "app-settings") {
        return MobileAppSettings();
      }
      return MobileHomeScene();
    }

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 16, 12, 43),
        ),
        height: screen_height,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              // Main Page Content
              Column(
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: buildPageContent(pageName),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                  Container(
                    width: screen_width,
                    height: 50 * fem,
                  ),
                ],
              ),

              // More Navigation Options Box
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(96, 0, 0, 0),
                        spreadRadius: 5,
                        blurRadius: 20 * fem,
                        offset: Offset(0, -10),
                        // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(52, 0, 0, 0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            border: Border(
                                top: BorderSide(
                                    color:
                                        Color.fromARGB(206, 255, 255, 255)))),
                        height: isBottomSheetVisible ? 250 * fem : 0,
                        duration: Duration(milliseconds: 300),
                        child: SingleChildScrollView(
                          child: Container(
                            height: 200 * fem,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isBottomSheetVisible =
                                              !isBottomSheetVisible;
                                          commonVars
                                              .updatePageName("talk-to-aanya");
                                        });
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      4.0), // Adjust the padding as needed
                                              child: Image.asset(
                                                  'assets/images/favicon.png',
                                                  width: 35 * fem),
                                            ),
                                            Text(
                                              "Talk to Aanya",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isBottomSheetVisible =
                                              !isBottomSheetVisible;
                                          commonVars
                                              .updatePageName("image-gen");
                                        });
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      4.0), // Adjust the padding as needed
                                              child: Icon(
                                                Icons.image_outlined,
                                                size: 35 * fem,
                                                color: Color.fromARGB(
                                                    255, 156, 161, 255),
                                              ),
                                            ),
                                            Text(
                                              "Generate Images",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 156, 161, 255)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isBottomSheetVisible =
                                              !isBottomSheetVisible;
                                          commonVars
                                              .updatePageName("image-desc");
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            30 * fem, 10 * fem, 0, 10 * fem),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      4.0), // Adjust the padding as needed
                                              child: Icon(
                                                Icons.image_search,
                                                size: 35 * fem,
                                                color: Color.fromARGB(
                                                    255, 156, 161, 255),
                                              ),
                                            ),
                                            Text(
                                              "Ask by Image",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 156, 161, 255)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isBottomSheetVisible =
                                              !isBottomSheetVisible;
                                          commonVars.updatePageName("settings");
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 10 * fem, 80 * fem, 10 * fem),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      4.0), // Adjust the padding as needed
                                              child: Icon(
                                                Icons.settings,
                                                size: 35 * fem,
                                                color: Color.fromARGB(
                                                    255, 156, 161, 255),
                                              ),
                                            ),
                                            Text(
                                              "Settings",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 156, 161, 255)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(top: 20 * fem))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50 * width_fem)),
          gradient: LinearGradient(
            begin: Alignment(0, 1),
            end: Alignment(0, -1.5),
            colors: <Color>[
              Color.fromARGB(0, 142, 187, 255),
              Color.fromARGB(90, 255, 158, 161),
              Color.fromARGB(0, 67, 0, 174),
            ],
            stops: <double>[0, 0, 0.8],
          ),
        ),
        child: CurvedNavigationBar(
          index: 0,
          animationDuration: Duration(milliseconds: 500),
          height: 60 * fem,
          buttonBackgroundColor: micButtonClicked
              ? Color.fromARGB(255, 255, 255, 255)
              : Color.fromARGB(166, 120, 124, 255),
          color: micButtonClicked
              ? Color.fromARGB(12, 120, 125, 255)
              : Color.fromARGB(134, 120, 125, 255),
          backgroundColor: Color.fromARGB(0, 42, 12, 99),
          items: [
            Icon(
              Icons.home,
              size: 20,
              color: micButtonClicked
                  ? Color.fromARGB(110, 255, 255, 255)
                  : Colors.white,
            ),
            Icon(
              Icons.mic,
              size: 30,
              color: micButtonClicked
                  ? Color.fromARGB(255, 0, 0, 0)
                  : Colors.white,
            ),
            Icon(
              Icons.keyboard_arrow_up_outlined,
              size: 20,
              color: micButtonClicked
                  ? Color.fromARGB(110, 255, 255, 255)
                  : Colors.white,
            ),
          ],
          onTap: (index) {
            if (index == 1) {
              // Toggle Speech to Text Listening when the mic button is clicked
              flutterTts.stop();
              setState(() {
                if (micButtonClicked == false) {
                  micButtonClicked = !micButtonClicked;
                  startListening();
                } else {
                  micButtonClicked = false;
                  stopListening();
                }
              });
            } else if (index == 2) {
              // Toggle the visibility of the container when the arrow button is pressed
              setState(() {
                isBottomSheetVisible = !isBottomSheetVisible;
                micButtonClicked = false;
                stopListening();
              });
            } else {
              // Handle other button taps
              commonVars.updatePageName('home-scene');
              setState(() {
                isBottomSheetVisible = false;
                micButtonClicked = false;
                stopListening();
              });
            }
          },
        ),
      ),
    );
  }
}
