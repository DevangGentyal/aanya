import 'dart:io';
import 'dart:ui';
import 'package:Aanya/common_vars.dart';
import 'package:Aanya/database/user_management.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/modules/speech_to_text_windows.dart';
import 'package:Aanya/modules/text_to_speech.dart';
import 'package:Aanya/pages/desktop_pages/app-settings.dart';
import 'package:Aanya/pages/desktop_pages/home-scene.dart';
import 'package:Aanya/pages/desktop_pages/image-description.dart';
import 'package:Aanya/pages/desktop_pages/image-generation.dart';
import 'package:Aanya/pages/desktop_pages/manage-devices.dart';
import 'package:Aanya/pages/desktop_pages/settings-page.dart';
import 'package:Aanya/pages/desktop_pages/talk-to-aanya.dart';
import 'package:Aanya/pages/desktop_pages/user-profile-page.dart';
import 'package:Aanya/utils/get_device_info.dart';
import 'package:Aanya/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:window_manager/window_manager.dart';

int current_nav_index = 0;
bool isRecording = false;

class DesktopHomePage extends StatefulWidget {
  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  bool isMoreOptionsVisible = false;
  bool micClicked = false;
  bool isFullScreen = false;
  stt.SpeechToText _speech = stt.SpeechToText();
  var userManagement = Get.find<UserManagement>();

  @override
  void initState() {
    super.initState();
    initTTS();
    if (Platform.isMacOS) {
      _speech.initialize();
    }
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Set Active Device
    await userManagement.updateUserInfo(
        'active_device', await getCurrentDeviceId());
    await userManagement.fetchUserData();
  }
  
  @override
  Widget build(BuildContext context) {

    reciver_context = context;
    CommonVariables commonVars = Provider.of<CommonVariables>(context);
    String pageName = commonVars.pageName;

    flutterTts.startHandler = () {
      commonVars.updateAanyaStatus("Speaking");
    };
    flutterTts.completionHandler = () {
      commonVars.updateAanyaStatus("Idle");
    };

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.fullscreen,
              color: Colors.white,
              size: 20 * width_fem,
            ),
            onPressed: () async {
              if (isFullScreen) {
                await WindowManager.instance.setFullScreen(false);
                setState(() {
                  isFullScreen = false;
                  current_nav_index = 0;
                });
              } else {
                await WindowManager.instance.setFullScreen(true);
                setState(() {
                  isFullScreen = true;
                  current_nav_index = 0;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 20 * width_fem,
            ),
            onPressed: () async {
              await userManagement.updateUserInfo('active_device', 'none');
              exit(0);
            },
          ),
        ],
        toolbarHeight: isFullScreen ? 0 : 50 * height_fem,
        backgroundColor: Color.fromRGBO(4, 1, 24, 1),
        surfaceTintColor: Color.fromRGBO(4, 1, 24, 1),
      ),
      backgroundColor: Color(0xff040118),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        child: Container(
          child: Stack(
            children: [
              // Whole Page Content
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: buildPageContent(pageName),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
              // Bottom Shadow
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 250 * height_fem,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0, -1),
                      end: Alignment(0, 1),
                      colors: <Color>[
                        Color.fromARGB(0, 0, 0, 0),
                        Color.fromRGBO(0, 0, 0, 0.425)
                      ],
                      stops: <double>[0, 0.5],
                    ),
                  ),
                ),
              ),
              // More Options Navigation Box
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 600 * width_fem,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(96, 0, 0, 0),
                        spreadRadius: 5,
                        blurRadius: 20 * width_fem,
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
                        height: isMoreOptionsVisible ? 350 * height_fem : 0,
                        duration: Duration(milliseconds: 300),
                        child: SingleChildScrollView(
                          child: Container(
                            height: 200 * height_fem,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Talk to Aanya
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isMoreOptionsVisible =
                                              !isMoreOptionsVisible;
                                        });
                                        commonVars
                                            .updatePageName("talk-to-aanya");
                                      },
                                      child: Container(
                                        width: 210 * width_fem,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      4.0), // Adjust the padding as needed
                                              child: Image.asset(
                                                  'assets/images/favicon.png',
                                                  width: 35 * height_fem),
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
                                    // Image Generation
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isMoreOptionsVisible =
                                              !isMoreOptionsVisible;
                                        });
                                        commonVars.updatePageName("image-gen");
                                      },
                                      child: Container(
                                        width: 210 * width_fem,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      4.0), // Adjust the padding as needed
                                              child: Icon(
                                                Icons.image_outlined,
                                                size: 35 * width_fem,
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
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Image Description
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isMoreOptionsVisible =
                                              !isMoreOptionsVisible;
                                        });
                                        commonVars.updatePageName("image-desc");
                                      },
                                      child: Container(
                                        width: 210 * width_fem,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      4.0), // Adjust the padding as needed
                                              child: Icon(
                                                Icons.image_search,
                                                size: 35 * width_fem,
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
                                    // Settings
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isMoreOptionsVisible =
                                              !isMoreOptionsVisible;
                                        });
                                        commonVars.updatePageName("settings");
                                      },
                                      child: Container(
                                        width: 210 * width_fem,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      4.0), // Adjust the padding as needed
                                              child: Icon(
                                                Icons.settings,
                                                size: 35 * width_fem,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Bottom Navigation Bar
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30 * width_fem),
                    width: 500 * width_fem,
                    height: 90 * height_fem,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(50 * width_fem)),
                      gradient: LinearGradient(
                        begin: Alignment(0, 1),
                        end: Alignment(0, -1),
                        colors: <Color>[
                          Color.fromARGB(0, 142, 187, 255),
                          Color.fromARGB(90, 255, 158, 161),
                          Color.fromARGB(0, 67, 0, 174),
                        ],
                        stops: <double>[0, 0, 0.98],
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(50 * width_fem)),
                      child: CurvedNavigationBar(
                        index: current_nav_index,
                        buttonBackgroundColor: micClicked
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(166, 120, 124, 255),
                        color: micClicked
                            ? Color.fromARGB(12, 120, 125, 255)
                            : Color.fromARGB(134, 120, 125, 255),
                        backgroundColor: Color.fromARGB(0, 42, 12, 99),
                        width: 500 * width_fem,
                        height: 65 * height_fem,
                        items: [
                          Icon(
                            Icons.home,
                            color: micClicked
                                ? Color.fromARGB(110, 255, 255, 255)
                                : Colors.white,
                            size: 30 * width_fem,
                          ),
                          Icon(
                            Icons.mic,
                            color: micClicked
                                ? Color.fromARGB(255, 0, 0, 0)
                                : Colors.white,
                            size: 30 * width_fem,
                          ),
                          Icon(
                            Icons.keyboard_arrow_up_outlined,
                            color: micClicked
                                ? Color.fromARGB(110, 255, 255, 255)
                                : Colors.white,
                            size: 30 * width_fem,
                          ),
                        ],
                        onTap: (index) async {
                          if (index == 0) {
                            // Navigate to HomeScene
                            setState(() {
                              micClicked = false;
                              isMoreOptionsVisible = false;
                              commonVars.updatePageName('home-scene');
                            });
                          } else if (index == 1) {
                            // Toggle Listening

                            isRecording
                                ? stopWindowsListening(context, commonVars)
                                : startWindowsListening(commonVars);

                            setState(() {
                              micClicked = !micClicked;
                              isMoreOptionsVisible = false;
                            });
                          } else if (index == 2) {
                            // Open More Options Dialog
                            setState(() {
                              micClicked = false;
                              isMoreOptionsVisible = !isMoreOptionsVisible;
                            });
                          }
                        },
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildPageContent(String pageName) {
  if (pageName == "home-scene") {
    return DesktopHomeScene();
  } else if (pageName == "talk-to-aanya") {
    return DesktopTalktoAanya();
  } else if (pageName == "image-gen") {
    return DesktopImageGen();
  } else if (pageName == "image-desc") {
    return DesktopImageDesc();
  } else if (pageName == "settings") {
    return DesktopSettings();
  } else if (pageName == "profile") {
    return DesktopUserProfile();
  } else if (pageName == "app-settings") {
    return DesktopAppSettings();
  } else if (pageName == "manage-devices") {
    return DesktopManageDevices();
  }
  return DesktopHomeScene();
}
