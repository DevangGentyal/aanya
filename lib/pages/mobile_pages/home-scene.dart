import 'package:Aanya/database/user_management.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/modules/opening_apps.dart';
import 'package:Aanya/widgets/ellipse.dart';
import 'package:Aanya/widgets/feature_item.dart';
import 'package:flutter/material.dart';
import 'package:Aanya/widgets/user_profile_menu.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:Aanya/common_vars.dart';

class MobileHomeScene extends StatefulWidget {
  @override
  State<MobileHomeScene> createState() => _MobileHomeSceneState();
}

class _MobileHomeSceneState extends State<MobileHomeScene> {
  @override
  Widget build(BuildContext context) {
    CommonVariables commvars = Provider.of<CommonVariables>(context);
    var userManagement = Get.find<UserManagement>();
    reciver_context = context;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          center: Alignment(0, -1.03),
          radius: 1,
          colors: <Color>[Color.fromARGB(255, 64, 18, 170), Color(0xff100c2b)],
          stops: <double>[0, 1],
        )),
        width: double.infinity,
        child: Stack(
          children: [
            Ellipse(
              left: -30 * fem,
              top: 400 * fem,
              width: 124 * fem,
              height: 119 * fem,
              innerColor: Color.fromARGB(143, 97, 95, 243),
              outerColor: Color.fromARGB(0, 83, 82, 159),
            ),
            Ellipse(
              left: 300 * fem,
              top: 300 * fem,
              width: 130 * fem,
              height: 119 * fem,
              innerColor: Color.fromARGB(171, 97, 95, 243),
              outerColor: Color.fromARGB(0, 83, 82, 159),
            ),
            Container(
              height: screen_height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Section Including User Icon and Header section
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        21 * fem, 29 * fem, 23 * fem, 0 * fem),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // UserIcon
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                265 * fem, 20 * fem, 0 * fem, 0 * fem),
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
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            // header6CL (5:13)
                            width: 600,
                            margin: EdgeInsets.fromLTRB(
                                2 * fem, 0 * fem, 0 * fem, 0 * fem),
                            padding: EdgeInsets.symmetric(
                                vertical: 20 * fem, horizontal: 10 * fem),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10 * ffem),
                                  bottomRight: Radius.circular(10 * ffem)),
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 255, 190, 185),
                                ),
                                left: BorderSide(
                                    color: Color.fromARGB(255, 255, 190, 185)),
                                right: BorderSide(
                                    color: Color.fromARGB(255, 255, 190, 185)),
                              ),
                            ),
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 0 * fem,
                                  sigmaY: 0 * fem,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 10),
                                      child: Text(
                                        'Hey, ${userManagement.name.value}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 28 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      // letsseewhatcanidoforyouwcG (5:16)
                                      'Lets see what can I do for you ?',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1 * ffem / fem,
                                        color: Color.fromRGBO(251, 192, 194, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15 * fem,
                          ),
                          Container(
                            width: double.infinity,
                            child: Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 315 * fem,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromRGBO(251, 192, 194, 1),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10 * fem),
                                      gradient: LinearGradient(
                                        begin: Alignment(0.90, 0),
                                        end: Alignment(-2, -1),
                                        colors: <Color>[
                                          Color.fromARGB(0, 59, 4, 93),
                                          Color.fromARGB(0, 44, 29, 97),
                                          Color.fromARGB(219, 151, 135, 245),
                                        ],
                                        stops: <double>[0, 0, 1],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x3f000000),
                                          offset: Offset(0 * fem, 4 * fem),
                                          blurRadius: 2 * fem,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  20 * ffem,
                                                  20 * ffem,
                                                  10 * ffem,
                                                  20 * ffem),
                                              constraints: BoxConstraints(
                                                maxWidth: 200 * fem,
                                              ),
                                              child: Text(
                                                'Elevate Your Experience, Command with Voice',
                                                style: TextStyle(
                                                  fontSize: 14 * ffem,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.2125 * ffem / fem,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 10 * ffem, 0),
                                              margin: EdgeInsets.all(10 * ffem),
                                              width: 80 * ffem,
                                              height: 80 * ffem,
                                              child: SizedBox(
                                                child: Image.asset(
                                                  'assets/images/animated-favicon.gif',
                                                  colorBlendMode:
                                                      BlendMode.overlay,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            // )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                //Going to Voice Page
                                                commvars.updatePageName(
                                                    "talk-to-aanya");
                                              },
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    15, 0, 0, 10),
                                                // letstalkbuttonqzU (5:19)
                                                width: 72 * fem,
                                                height: 32 * fem,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      128, 124, 130, 243),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10 * fem),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Let’s Talk',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height:
                                                          1.2125 * ffem / fem,
                                                      color: Color(0xffffffff),
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Body Section Including Features Tab and Recent Activites
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20 * ffem, 0, 0),
                    width: double.infinity,
                    child: Expanded(
                      child: Column(
                        children: [
                          // Features Tab
                          Container(
                            margin: EdgeInsets.fromLTRB(0 * ffem, 0, 0, 0),
                            width: 316 * fem,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        10 * ffem, 0, 0, 10 * ffem),
                                    child: Text(
                                      "Features",
                                      style: TextStyle(
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2125 * ffem / fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                  // Feature Items
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Feature 1
                                        FeatureItem(
                                          text: "Chat with \nAanya",
                                          fontSize: 12 * fem,
                                          iconSize: 20 * fem,
                                          icon1: Icons.chat_outlined,
                                          icon2:
                                              Icons.arrow_forward_ios_outlined,
                                          backgroundColor:
                                              Color.fromARGB(205, 31, 33, 69),
                                          nextPageName: "talk-to-aanya",
                                          width: 100 * fem,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15 * ffem,
                                              vertical: 10 * fem),
                                        ),
                                        // Feature 2
                                        FeatureItem(
                                          text: "Generate \nImages",
                                          fontSize: 12 * fem,
                                          iconSize: 20 * fem,
                                          icon1: Icons.image_outlined,
                                          icon2:
                                              Icons.arrow_forward_ios_outlined,
                                          backgroundColor:
                                              Color.fromARGB(205, 31, 33, 69),
                                          nextPageName: "image-gen",
                                          width: 100 * fem,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15 * ffem,
                                              vertical: 10 * fem),
                                        ),
                                        // Feature 3
                                        FeatureItem(
                                          text: "Search by\nImage",
                                          fontSize: 12 * fem,
                                          iconSize: 20 * fem,
                                          icon1: Icons.image_search_outlined,
                                          icon2:
                                              Icons.arrow_forward_ios_outlined,
                                          backgroundColor:
                                              Color.fromARGB(205, 31, 33, 69),
                                          nextPageName: "image-desc",
                                          width: 100 * fem,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15 * ffem,
                                              vertical: 10 * fem),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Recent Activites tab
                          Container(
                            width: 316 * fem,
                            margin:
                                EdgeInsets.fromLTRB(10 * ffem, 10 * ffem, 0, 0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // Recent Activites Title
                                    margin: EdgeInsets.fromLTRB(
                                        6 * fem, 17 * fem, 7 * fem, 7 * fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Recent Activites',
                                            style: TextStyle(
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.more_horiz_outlined,
                                          size: 20 * ffem,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // Today Sub title
                                    margin: EdgeInsets.fromLTRB(
                                        6 * fem, 0 * fem, 0 * fem, 10 * fem),
                                    child: Text(
                                      'Today',
                                      style: TextStyle(
                                        fontSize: 8 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2125 * ffem / fem,
                                        color: Color(0x75ffffff),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: buildActivies(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildActivies() {
    List<Widget> recent_activites_widgets = [];
    int count = 1;
    if (user_management.recent_activites.length == 0) {
      for (int i = 1; i <= 4; i++) {
        recent_activites_widgets.add(
          Container(
            margin: EdgeInsets.only(bottom: 10 * ffem),
            padding: EdgeInsets.symmetric(
                vertical: 10 * ffem, horizontal: 20 * ffem),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff1f2145),
              borderRadius: BorderRadius.circular(10 * fem),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  // miciconiwe (5:90)
                  margin: EdgeInsets.only(
                    right: 20 * ffem,
                  ),
                  width: 8 * fem,
                  height: 13 * fem,
                  child: Icon(
                    Icons.mic_none_outlined,
                    size: 20 * ffem,
                    color: Color(0xbcfbc0c2),
                  ),
                ),
                Container(
                  // whatisthecurrentpriceofplaysta (5:95)
                  child: Text(
                    "Your Activity Here",
                    style: TextStyle(
                      fontSize: 10 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1 * ffem / fem,
                      color: Color(0xbcfbc0c2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return recent_activites_widgets;
    }
    for (var entry in user_management.recent_activites.reversed) {
      if (count > 4) {
        break;
      }
      recent_activites_widgets.add(
        Container(
          margin: EdgeInsets.only(bottom: 10 * ffem),
          padding:
              EdgeInsets.symmetric(vertical: 10 * ffem, horizontal: 20 * ffem),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff1f2145),
            borderRadius: BorderRadius.circular(10 * fem),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // mic icon
              Container(
                margin: EdgeInsets.only(
                  right: 20 * ffem,
                ),
                width: 8 * fem,
                height: 13 * fem,
                child: Icon(
                  Icons.mic_none_outlined,
                  size: 20 * ffem,
                  color: Color(0xbcfbc0c2),
                ),
              ),
              // activity text
              Container(
                constraints: BoxConstraints(maxWidth: 200 * fem),
                child: Text(
                  entry['prompt'],
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 10 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1 * ffem / fem,
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
    return recent_activites_widgets;
  }
}
