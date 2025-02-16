import 'dart:ui';

import 'package:Aanya/common_vars.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/utils/recent_activities.dart';
import 'package:Aanya/widgets/ellipse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopTalktoAanya extends StatefulWidget {
  @override
  State<DesktopTalktoAanya> createState() => _DesktopTalktoAanyaState();
}

class _DesktopTalktoAanyaState extends State<DesktopTalktoAanya> {
 
  @override
  Widget build(BuildContext context) {
    reciver_context = context;
    CommonVariables commonVars = Provider.of<CommonVariables>(context);
    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(4, 1, 24, 1),
        ),
        child: Stack(
          children: [
            // Lights Elipse

            Ellipse(
              left: 1250 * width_fem,
              top: 40 * height_fem,
              width: 300 * width_fem,
              height: 300 * height_fem,
              innerColor: Color.fromARGB(99, 150, 0, 244),
              outerColor: Color.fromARGB(
                0,
                151,
                0,
                244,
              ),
            ),

            // Body
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Left Side
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Status Box
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20 * width_fem,
                            vertical: 10 * height_fem),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff8ebbff)),
                          color: Color(0x56494c89),
                          borderRadius: BorderRadius.circular(20 * width_fem),
                        ),
                        child: Center(
                          child: Text(
                            commonVars.aanyaStatus,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20 * fwidth_fem,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff8ebbff),
                            ),
                          ),
                        ),
                      ),
                      // Aanya Model
                      Container(
                        width: 500 * width_fem,
                        height: 800 * height_fem,
                        child: ClipRRect(
                          child: Image.asset(
                            "assets/images/aanya-temp.png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Right Side
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Text View with stars
                      Container(
                        margin: EdgeInsets.only(
                            top: 80 * height_fem,
                            left: 30 * width_fem,
                            right: 30 * width_fem),
                        width: 800 * width_fem,
                        height: 400 * width_fem,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 40 * width_fem,
                              top: 50 * height_fem,
                              child: SizedBox(
                                width: 100 * width_fem,
                                height: 120 * height_fem,
                                child: Image.asset(
                                  'assets/images/animated-favicon-2.gif',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 700 * width_fem,
                              top: 300 * height_fem,
                              child: SizedBox(
                                width: 80 * width_fem,
                                height: 80 * height_fem,
                                child: Image.asset(
                                  'assets/images/animated-favicon-2.gif',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            //Input/Output Display Text
                            Center(
                              child: GestureDetector(
                                // On Long Press
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 200 * fem,
                                            horizontal: 200 * fem),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10, sigmaY: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    Color.fromARGB(14, 0, 0, 0),
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        144, 255, 255, 255)),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: buildRecentActivites(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                // Default
                                child: Container(
                                  width: 500 * fwidth_fem,
                                  height: 500 * fwidth_fem,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(0, 158, 158, 158), // Top color
                                        const Color.fromARGB(
                                            0, 255, 255, 255), // Center color
                                        Color.fromARGB(0, 158, 158, 158), // Bottom color
                                      ],
                                    ),
                                  ),
                                  child: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        begin: Alignment(0.0, -2.0),
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(0, 0, 0, 0),
                                          Color.fromARGB(255, 255, 255, 255),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        stops: [0, 0.6, 1],
                                      ).createShader(bounds);
                                    },
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 50),
                                        child: Center(
                                          child: Text(
                                            commonVars.responseRecived
                                                ? commonVars.displayResponse
                                                : commonVars.recognizedWords,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 50 * fwidth_fem,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
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
                      // Wave Animation
                      Container(
                        margin: EdgeInsets.only(
                            left: 20 * width_fem,
                            right: 20 * width_fem,
                            bottom: 20 * width_fem),
                        child: Align(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Color(0xff040118),
                              BlendMode.plus,
                            ),
                            child: SizedBox(
                              width: 450 * width_fem,
                              height: 250 * height_fem,
                              child: Image.asset(
                                "assets/images/wave-animation.gif",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Ellipse(
              left: 130 * width_fem,
              top: 700 * height_fem,
              width: 300 * width_fem,
              height: 300 * height_fem,
              innerColor: Color.fromARGB(144, 211, 153, 250),
              outerColor: Color.fromARGB(0, 211, 153, 250),
            ),
            Ellipse(
              left: -100 * width_fem,
              top: 0 * height_fem,
              width: 200 * width_fem,
              height: 200 * height_fem,
              innerColor: Color.fromARGB(176, 211, 153, 250),
              outerColor: Color.fromARGB(0, 211, 153, 250),
            ),
          ],
        ),
      ),
    );
  }
}

Widget addPrompt(String prompt) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical: 20 * fem),
    margin: EdgeInsets.fromLTRB(30 * fem, 10 * fem, 10 * fem, 0),
    decoration: BoxDecoration(
      color: Color.fromARGB(179, 5, 7, 39),
      borderRadius: BorderRadius.all(
        Radius.circular(10 * fem),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 220 * fem),
          child: Text(
            prompt,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16 * fem,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10 * fem),
          width: 20 * fem,
          height: 20 * fem,
          child: Image.asset(
            'assets/images/user.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  );
}

Widget addResponse(String response) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical: 20 * fem),
    margin: EdgeInsets.fromLTRB(10 * fem, 10 * fem, 30 * fem, 0),
    decoration: BoxDecoration(
      color: Color.fromARGB(179, 26, 7, 61),
      borderRadius: BorderRadius.all(
        Radius.circular(10 * fem),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10 * fem),
          width: 20 * fem,
          height: 20 * fem,
          child: Image.asset(
            'assets/images/favicon.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 220 * fem),
          child: Text(
            response,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16 * fem,
            ),
          ),
        ),
      ],
    ),
  );
}
