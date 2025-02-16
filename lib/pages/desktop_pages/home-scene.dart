import 'dart:ui';
import 'package:Aanya/database/user_management.dart';
import 'package:Aanya/modules/device_request_reciever.dart';

import 'package:Aanya/widgets/feature_item.dart';
import 'package:Aanya/widgets/user_profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:Aanya/common_vars.dart';

class DesktopHomeScene extends StatelessWidget {
  final userManagement = Get.find<UserManagement>();
  @override
  Widget build(BuildContext context) {
    reciver_context = context;
    CommonVariables commvars = Provider.of<CommonVariables>(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0.3, 1.5),
            colors: <Color>[Color(0xff040118), Color.fromRGBO(27, 22, 59, 1)],
            stops: <double>[0, 1],
          ),
        ),
        child: Column(
          children: [
            //  Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50 * width_fem),
                  child: Align(
                    child: SizedBox(
                      width: 200 * width_fem,
                      height: 80 * height_fem,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // UserIcon
                Container(
                  margin: EdgeInsets.only(right: 50 * width_fem),
                  height: 70 * height_fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // User Pop up Button
                      Theme(
                        data: Theme.of(context).copyWith(
                          popupMenuTheme: PopupMenuThemeData(
                            color: Color.fromARGB(255, 19, 12,
                                60), // Your desired background color in HEX
                          ),
                        ),
                        child: UserProfileMenu(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //  User Greeting Header
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 50 * fem, horizontal: 20 * fem),
              width: 1358 * width_fem,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10 * ffem),
                ),
                gradient: LinearGradient(
                  begin: Alignment(-0, 1),
                  end: Alignment(-0, -0.467),
                  colors: <Color>[
                    Color.fromARGB(141, 102, 52, 143),
                    Color.fromARGB(0, 4, 1, 24),
                  ],
                  stops: <double>[0, 1],
                ),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 0 * width_fem,
                    sigmaY: 0 * width_fem,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        // heydevang4AB (31:120)
                        margin: EdgeInsets.only(bottom: 15 * height_fem),
                        child: Text(
                          'Hey, ${userManagement.name.value}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 50 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // letsseewhatcanidoforyouNRm (31:121)
                        child: Text(
                          'Lets see what can I do for you?',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 22 * ffem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xfffbc0c2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Body Container
            Container(
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Left Section
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50 * width_fem),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Talk to Anya Box
                          Container(
                            margin: EdgeInsets.only(top: 50 * width_fem),
                            padding: EdgeInsets.symmetric(
                                vertical: 50 * width_fem,
                                horizontal: 20 * width_fem),
                            width: 600 * width_fem,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff9398fa)),
                              borderRadius:
                                  BorderRadius.circular(10 * width_fem),
                              gradient: LinearGradient(
                                begin: Alignment(-1.867, 1.54),
                                end: Alignment(0.75, -0.595),
                                colors: <Color>[
                                  Color(0x008ebbff),
                                  Color(0xa0ff9ea1),
                                  Color(0x004200ae),
                                ],
                                stops: <double>[0, 0, 0.98],
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Left Section
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Elevate Your Exp
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 360 * width_fem,
                                      ),
                                      child: Text(
                                        'Elevate Your Experience, Command with Voice',
                                        style: TextStyle(
                                          fontSize: 30 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 2 * ffem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    // Lets Talk Button
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 20 * height_fem),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          commvars
                                              .updatePageName('talk-to-aanya');
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Color.fromARGB(117, 0, 0, 0),
                                            padding: EdgeInsets.all(
                                                20.0 * width_fem),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            )),
                                        child: Row(children: [
                                          Text(
                                            "Lets Talk",
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontSize: 20.0 * width_fem,
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
                                  ],
                                ),
                                // Right Section
                                Container(
                                  width: 100 * width_fem,
                                  height: 100 * height_fem,
                                  child: Image.asset(
                                    'assets/images/animated-favicon-2.gif',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Devices Conneted
                          Container(
                            margin: EdgeInsets.only(top: 30 * width_fem),
                            height: 200 * height_fem,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Devices Heading
                                Container(
                                  width: 600 * width_fem,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.fromLTRB(
                                        //     0 * width_fem, 0 * width_fem, 0 * width_fem, 30 * width_fem),
                                        child: Text(
                                          'Devices Connected',
                                          style: TextStyle(
                                            fontSize: 20 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2125 * ffem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.more_horiz,
                                          color: Colors.white,
                                          size: 20 * width_fem,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Device Items
                                Container(
                                  width: 600 * width_fem,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Item 1
                                      Container(
                                        padding: EdgeInsets.all(20 * width_fem),
                                        decoration: BoxDecoration(
                                          color: Color(0xff1f2145),
                                          borderRadius: BorderRadius.circular(
                                              10 * width_fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x3f000000),
                                              offset: Offset(
                                                  0 * width_fem, 4 * width_fem),
                                              blurRadius: 2 * width_fem,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right:
                                                              20 * width_fem),
                                                      child: Text(
                                                        'My \nComputer',
                                                        style: TextStyle(
                                                          fontSize: 20 * ffem,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 2 * ffem,
                                                          color:
                                                              Color(0xff8388ff),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 15 * width_fem),
                                                child: Text(
                                                  'Last Active: 08:30 PM',
                                                  style: TextStyle(
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.2125 * ffem,
                                                    color: Color(0x6b8388ff),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(20 * width_fem),
                                        decoration: BoxDecoration(
                                          color: Color(0xff1f2145),
                                          borderRadius: BorderRadius.circular(
                                              10 * width_fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x3f000000),
                                              offset: Offset(
                                                  0 * width_fem, 4 * width_fem),
                                              blurRadius: 2 * width_fem,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right:
                                                              20 * width_fem),
                                                      child: Text(
                                                        'My \nComputer',
                                                        style: TextStyle(
                                                          fontSize: 20 * ffem,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 2 * ffem,
                                                          color:
                                                              Color(0xff8388ff),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 15 * width_fem),
                                                child: Text(
                                                  'Last Active: 08:30 PM',
                                                  style: TextStyle(
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.2125 * ffem,
                                                    color: Color(0x6b8388ff),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(20 * width_fem),
                                        decoration: BoxDecoration(
                                          color: Color(0xff1f2145),
                                          borderRadius: BorderRadius.circular(
                                              10 * width_fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x3f000000),
                                              offset: Offset(
                                                  0 * width_fem, 4 * width_fem),
                                              blurRadius: 2 * width_fem,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right:
                                                              20 * width_fem),
                                                      child: Text(
                                                        'My \nComputer',
                                                        style: TextStyle(
                                                          fontSize: 20 * ffem,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 2 * ffem,
                                                          color:
                                                              Color(0xff8388ff),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 15 * width_fem),
                                                child: Text(
                                                  'Last Active: 08:30 PM',
                                                  style: TextStyle(
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.2125 * ffem,
                                                    color: Color(0x6b8388ff),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // Right Section
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 50 * width_fem),
                        width: 600 * width_fem,
                        child: Column(
                          children: [
                            // Features Section
                            Container(
                              margin: EdgeInsets.only(top: 50 * width_fem),
                              height: 220 * height_fem,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Features Heading
                                  Container(
                                    width: 600 * width_fem,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Features',
                                            style: TextStyle(
                                              fontSize: 20 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 2 * ffem,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.more_horiz,
                                            color: Colors.white,
                                            size: 20 * width_fem,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  //  Features Items
                                  Container(
                                    width: 600 * width_fem,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Feature 1
                                        FeatureItem(
                                          text: "Chat with \nAanya",
                                          fontSize: 16 * width_fem,
                                          iconSize: 30 * width_fem,
                                          icon1: Icons.chat_outlined,
                                          icon2:
                                              Icons.arrow_forward_ios_outlined,
                                          backgroundColor:
                                              Color.fromARGB(205, 31, 33, 69),
                                          nextPageName: "talk-to-aanya",
                                          width: 180 * width_fem,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20 * ffem,
                                              vertical: 30 * fem),
                                        ),
                                        // Feature 2
                                        FeatureItem(
                                          text: "Generate \nImages",
                                          fontSize: 16 * width_fem,
                                          iconSize: 30 * width_fem,
                                          icon1: Icons.image_outlined,
                                          icon2:
                                              Icons.arrow_forward_ios_outlined,
                                          backgroundColor:
                                              Color.fromARGB(205, 31, 33, 69),
                                          nextPageName: "image-gen",
                                          width: 180 * width_fem,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20 * ffem,
                                              vertical: 30 * fem),
                                        ),
                                        // Feature 3
                                        FeatureItem(
                                          text: "Search by\nImage",
                                          fontSize: 15 * width_fem,
                                          iconSize: 30 * width_fem,
                                          icon1: Icons.image_search_outlined,
                                          icon2:
                                              Icons.arrow_forward_ios_outlined,
                                          backgroundColor:
                                              Color.fromARGB(205, 31, 33, 69),
                                          nextPageName: "image-desc",
                                          width: 180 * width_fem,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20 * ffem,
                                              vertical: 30 * fem),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Recent Activies Section
                            Container(
                              margin: EdgeInsets.only(top: 30 * width_fem),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Recent Activites Heading
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 600 * width_fem,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text(
                                                  'Recent Activities',
                                                  style: TextStyle(
                                                    fontSize: 20 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 2 * ffem,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Icon(
                                                  Icons.more_horiz,
                                                  color: Colors.white,
                                                  size: 20 * width_fem,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10 * width_fem),
                                          child: Text(
                                            'Today',
                                            style: TextStyle(
                                              fontSize: 18 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.2125 * ffem,
                                              color: Color(0x75ffffff),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Recent Activites Items
                                  Container(
                                    height: 200 * height_fem,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: buildActivies(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildActivies() {
    List<Widget> recent_activites_widgets = [];
    int count = 1;
    if (userManagement.recent_activites.length == 0) {
      for (int i = 1; i <= 3; i++) {
        recent_activites_widgets.add(
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 20 * width_fem, vertical: 10 * width_fem),
            decoration: BoxDecoration(
              color: Color(0xff1f2145),
              borderRadius: BorderRadius.circular(10 * width_fem),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20 * width_fem),
                    child: Icon(
                      Icons.mic_outlined,
                      color: Color(0xbcfbc0c2),
                      size: 30 * width_fem,
                    )),
                Container(
                  margin: EdgeInsets.only(left: 30 * width_fem),
                  constraints: BoxConstraints(maxWidth: 400 * width_fem),
                  child: Text(
                    "Your Activity Here",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 18 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 2 * ffem,
                      color: Color(0xbcfbc0c2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      for (var entry in userManagement.recent_activites.reversed) {
        if (count > 3) {
          break;
        }
        recent_activites_widgets.add(
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 20 * width_fem, vertical: 10 * width_fem),
            decoration: BoxDecoration(
              color: Color(0xff1f2145),
              borderRadius: BorderRadius.circular(10 * width_fem),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20 * width_fem),
                    child: Icon(
                      Icons.mic_outlined,
                      color: Color(0xbcfbc0c2),
                      size: 30 * width_fem,
                    )),
                Container(
                  margin: EdgeInsets.only(left: 30 * width_fem),
                  constraints: BoxConstraints(maxWidth: 400 * width_fem),
                  child: Text(
                    entry['prompt'],
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 18 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 2 * ffem,
                      color: Color(0xbcfbc0c2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        count++;
      }
    }
    return recent_activites_widgets;
  }
}
