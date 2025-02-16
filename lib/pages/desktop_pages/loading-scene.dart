import 'package:Aanya/init_checks.dart';
import 'package:Aanya/common_vars.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:flutter/material.dart';

class DesktopLoadingScene extends StatefulWidget {
  @override
  State<DesktopLoadingScene> createState() => _DesktopLoadingSceneState();
}

class _DesktopLoadingSceneState extends State<DesktopLoadingScene> {
  bool init = false;
  @override
  Widget build(BuildContext context) {
    reciver_context = context;
    print("On Loading Scene");
    commonContext = context;
    return Scaffold(
      body: FutureBuilder<String>(
        future: initChecks(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                height: screen_height,
                decoration: BoxDecoration(
                  color: Color(0xff100c2b),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 128 * fem,
                      top: -210 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 383 * fem,
                          height: 353 * fem,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(107 * fem),
                              gradient: const RadialGradient(
                                center: Alignment(0, -0),
                                radius: 0.5,
                                colors: <Color>[
                                  Color.fromARGB(143, 97, 95, 243),
                                  Color.fromARGB(0, 83, 82, 159)
                                ],
                                stops: <double>[0, 1],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -105 * fem,
                      top: 673 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 195 * fem,
                          height: 199 * fem,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(107 * fem),
                              gradient: const RadialGradient(
                                center: Alignment(0, -0),
                                radius: 0.5,
                                colors: <Color>[
                                  Color.fromARGB(143, 97, 95, 243),
                                  Color.fromARGB(0, 83, 82, 159)
                                ],
                                stops: <double>[0, 1],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 108 * fem,
                                height: 110 * fem,
                                child: Image.asset(
                                  'assets/images/animated-favicon.gif',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Text(
                                'Initializing ',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 25 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20 * fem),
                        width: 162 * fem,
                        height: 55 * fem,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ); // Show loading indicator
          } else {
            if (snapshot.hasError) {
              return Center(
                  child: Text("Error: ${snapshot.error}")); // Handle errors
            } else {
              return Container(
                color: Color(0xff100c2b),
              );
            }
          }
        },
      ),
    );
  }
}
