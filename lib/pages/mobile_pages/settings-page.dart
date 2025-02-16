import 'package:Aanya/common_vars.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/widgets/ellipse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileSettings extends StatelessWidget {
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
          child: Stack(
            children: [
              Ellipse(
                left: 199 * fem,
                top: 300 * fem,
                width: 195 * fem,
                height: 199 * fem,
                innerColor: Color.fromARGB(143, 179, 95, 243),
                outerColor: Color.fromARGB(0, 243, 95, 226),
              ),
              Ellipse(
                left: -82 * fem,
                top: -35 * fem,
                width: 195 * fem,
                height: 199 * fem,
                innerColor: Color.fromARGB(143, 97, 95, 243),
                outerColor: Color.fromARGB(0, 83, 82, 159),
              ),
              // Whole Page
              Container(
                height: screen_height - 200,
                margin: EdgeInsets.symmetric(
                    vertical: 100 * fem, horizontal: 20 * fem),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    Container(
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
                          horizontal: 0 * fem, vertical: 30 * fem),
                      height: 250 * fem,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              commonVars.updatePageName('profile');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20 * fem, horizontal: 20 * fem),
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
                                  vertical: 20 * fem, horizontal: 20 * fem),
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
                                  vertical: 20 * fem, horizontal: 20 * fem),
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
