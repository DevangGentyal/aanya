import 'package:Aanya/init_checks.dart';
import 'package:Aanya/common_vars.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/widgets/ellipse.dart';
import 'package:flutter/material.dart';

class MobileLoadingScene extends StatefulWidget {
  @override
  State<MobileLoadingScene> createState() => _MobileLoadingSceneState();
}

class _MobileLoadingSceneState extends State<MobileLoadingScene> {
  @override
  Widget build(BuildContext context) {
    reciver_context = context;
    reciver_context = context;
    print("On Loading Scene");
    return Scaffold(
      body: FutureBuilder<void>(
        future: initChecks(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: buildLoadingUI()); // Show loading indicator
          } else {
            if (snapshot.hasError) {
              return Center(
                  child: Text("Error: ${snapshot.error}")); // Handle errors
            } else {
              // Build your main content using the fetched data (snapshot.data)
              return Container();
            }
          }
        },
      ),
    );
  }
}

Widget buildLoadingUI() {
  return Scaffold(
      body: Container(
    height: screen_height,
    decoration: BoxDecoration(
      color: Color(0xff100c2b),
    ),
    child: Stack(
      children: [
        Ellipse(
          left: 128 * fem,
          top: -210 * fem,
          width: 383 * fem,
          height: 353 * fem,
          innerColor: Color.fromARGB(143, 97, 95, 243),
          outerColor: Color.fromARGB(0, 83, 82, 159),
        ),
        Ellipse(
          left: -105 * fem,
          top: 673 * fem,
          width: 195 * fem,
          height: 199 * fem,
          innerColor: Color.fromARGB(143, 97, 95, 243),
          outerColor: Color.fromARGB(0, 83, 82, 159),
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
  ));
}
