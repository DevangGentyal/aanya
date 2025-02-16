import 'dart:ui';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/utils/recent_activities.dart';
import 'package:flutter/material.dart';
import 'package:Aanya/common_vars.dart';
import 'package:provider/provider.dart';

class MobileTalktoAanya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final commonVars = Provider.of<CommonVariables>(context);
    reciver_context = context;
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        commonVars.updatePageName('home-scene');
      },
      child: Expanded(
        child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 16, 12, 43),
        ),
        child: Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Status Label
                  Container(
                    margin: EdgeInsets.only(top: 50 * ffem),
                    width: 95 * ffem,
                    height: 30 * ffem,
                    decoration: ShapeDecoration(
                      color: Color(0x56494C89),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF8EBBFF)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Align(
                      child: Text(
                        commonVars.aanyaStatus,
                        style: TextStyle(
                          color: Color(0xFF8EBBFF),
                          fontSize: 12 * ffem,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  // Aanya Model
                  Container(
                    width: 300 * fem,
                    height: 350 * fem,
                    child: Image.asset(
                      "assets/images/aanya-temp.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  //Input/Output Display Text
                  GestureDetector(
                    // On Long Press
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 30 * fem, horizontal: 10 * fem),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(14, 0, 0, 0),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(144, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(10),
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
                      width: 280 * ffem,
                      height: 180 * ffem,
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
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(0, 241, 227, 255),
                              Color.fromARGB(255, 255, 255, 255),
                              Color.fromARGB(0, 247, 234, 255)
                            ],
                            stops: [-1, 0.5, 1],
                          ).createShader(bounds);
                        },
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 70),
                            child: Center(
                              child: Text(
                                commonVars.responseRecived
                                    ? commonVars.displayResponse
                                    : commonVars.recognizedWords,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25.5 * ffem,
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
                  //Animated Waves
                  Container(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Color.fromARGB(255, 16, 12,
                            43), // Specify the color you want to blend with the image
                        BlendMode.plus,
                      ),
                      child: Image.asset(
                        'assets/images/wave-animation.gif',
                        width: MediaQuery.of(context).size.width,
                        height: 150 * fem,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 28 * fem,
              top: 280 * fem,
              child: Align(
                child: SizedBox(
                  width: 90 * fem,
                  height: 90 * fem,
                  child: Image.asset(
                    'assets/images/animated-favicon-2.gif',
                    colorBlendMode: BlendMode.clear,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 250 * fem,
              top: 80 * fem,
              child: Align(
                child: SizedBox(
                  width: 70 * fem,
                  height: 70 * fem,
                  child: Image.asset(
                    'assets/images/animated-favicon-2.gif',
                    colorBlendMode: BlendMode.overlay,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
