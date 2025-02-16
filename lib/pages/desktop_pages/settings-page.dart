import 'package:Aanya/common_vars.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final commonVars = Provider.of<CommonVariables>(context);
    reciver_context = context;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        commonVars.updatePageName('home-scene');
      },
      child: Expanded(
        child: Container(
          height: screen_height,
          child: Stack(
            children: [
              Positioned(
                // Red Gradient Top
                left: 1200 * fem,
                top: 500 * fem,
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
                            Color.fromARGB(143, 179, 95, 243),
                            Color.fromARGB(0, 243, 95, 226)
                          ],
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // Peach Gradient Top
                left: -82 * fem,
                top: 50 * fem,
                child: Align(
                  child: SizedBox(
                    width: 300 * fem,
                    height: 300 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(101.5 * fem),
                        gradient: const RadialGradient(
                          center: Alignment(0, 0),
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
              // Whole Page
              Container(
                height: screen_height - 200,
                margin: EdgeInsets.symmetric(
                    vertical: 100 * fem, horizontal: 0 * fem),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 100*fem),
                      child: Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35 * fem,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Body
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 100 * fem, vertical: 30 * fem),
                      height: 450 * fem,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              commonVars.updatePageName('profile');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 50 * fem, horizontal: 50 * fem),
                              backgroundColor: Color.fromARGB(124, 73, 85, 133),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Profile Settings",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20 * fem,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              commonVars.updatePageName('app-settings');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 50 * fem, horizontal: 50 * fem),
                              backgroundColor: Color.fromARGB(124, 73, 85, 133),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "App Settings",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20 * fem,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                             commonVars.updatePageName('manage-devices');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 50 * fem, horizontal: 50 * fem),
                              backgroundColor: Color.fromARGB(124, 73, 85, 133),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Manage Devices",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20 * fem,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
