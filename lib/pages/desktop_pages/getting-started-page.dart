import 'dart:io';

import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:flutter/material.dart';
import 'package:Aanya/common_vars.dart';
import 'package:google_fonts/google_fonts.dart';

class DesktopGettingStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  reciver_context  = context;
    print("on Getting Started");
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 20 * fem,
            ),
            onPressed: () async {
              exit(0);
            },
          ),
        ],
        toolbarHeight: 20,
        backgroundColor: Color.fromRGBO(4, 1, 24, 1),
      ),
      body: Expanded(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, -1),
              end: Alignment(0, 1),
              colors: <Color>[
                Color.fromRGBO(4, 1, 24, 1),
                Color.fromARGB(255, 104, 70, 146)
              ],
              stops: <double>[0, 1],
            ),
          ),
          child: Stack(
            children: [
              // Aanya Title Stack
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 100 * fem,
                    child: Text(
                      'AANYA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 120 * ffem,
                        fontWeight: FontWeight.w800,
                        height: 1.2125 * ffem / fem,
                        letterSpacing: 50 * fem,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.0
                          ..color = Color.fromARGB(59, 255, 255, 255),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -20 * fem,
                    child: Text(
                      'AANYA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 120 * ffem,
                        fontWeight: FontWeight.w800,
                        height: 1.2125 * ffem / fem,
                        letterSpacing: 50 * fem,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.0
                          ..color = Color.fromARGB(59, 255, 255, 255),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -20,
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      // height: 100,
                      child: Text(
                        'AANYA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 120 * ffem,
                          fontWeight: FontWeight.w800,
                          height: 1.2125 * ffem / fem,
                          letterSpacing: 50 * fem,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Bottom Container
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: screen_width,
                  height: 400 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(64 * fem),
                      topRight: Radius.circular(64 * fem),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment(1.184, -0.711),
                      end: Alignment(-1.301, 0.18),
                      colors: <Color>[
                        Color(0xffffcbcb),
                        Color(0xff745ff3),
                        Color(0xff8439d0)
                      ],
                      stops: <double>[0, 0.482, 0.852],
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Container
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 50 * fem, horizontal: 50 * fem),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Your Dynamic Assistant
                              Container(
                                child: Align(
                                  child: SizedBox(
                                    width: 415 * fem,
                                    height: 161 * fem,
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 60 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Your ',
                                            style: TextStyle(
                                              fontSize: 60 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'dynamic',
                                            style:
                                                GoogleFonts.oleoScriptSwashCaps(
                                              fontSize: 60 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.2575 * ffem / fem,
                                              fontStyle: FontStyle.italic,
                                              color: Color.fromARGB(255, 255, 190, 200),
                                              shadows: [
                                                Shadow(
                                                  blurRadius:
                                                      5, // Adjust the glow strength as needed
                                                  color: Color.fromARGB(228, 255, 175, 175),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' Assistant',
                                            style: TextStyle(
                                              fontSize: 60 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Dots
                              Container(
                                child: Text(
                                  ".......",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 60 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2125 * ffem / fem,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Right Container
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 50 * fem, horizontal: 50 * fem),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Get Started Button
                                Container(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/login_reg',
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff251642),
                                        padding: EdgeInsets.all(30.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                        )),
                                    child: Row(children: [
                                      Text(
                                        "Getting Started",
                                        style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 20.0 * fem,
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: Color(0xffffffff),
                                        size: 25,
                                      ),
                                    ]),
                                  ),
                                ),
                                // Lets Uncover Capabilites
                                Container(
                                  child: Align(
                                    child: SizedBox(
                                      width: 241 * fem,
                                      height: 73 * fem,
                                      child: Text(
                                        'Lets uncover the\ncapabilites',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 30 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2125 * ffem / fem,
                                          color: Color(0xff2b1a4b),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Dots
                                Container(
                                  child: Text(
                                    ".......",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 60 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2125 * ffem / fem,
                                        color: Color(0xff2b1a4b)),
                                  ),
                                )
                              ],
                            )),
                      ]),
                ),
              ),
              // Aanya Avatar
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Align(
                    child: Image.asset(
                      width: 500 * fem,
                      height: 900 * fem,
                      "assets/images/aanya-temp.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
