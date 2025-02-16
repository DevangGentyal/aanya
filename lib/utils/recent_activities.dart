import 'package:Aanya/common_vars.dart';
import 'package:Aanya/database/user_management.dart';
import 'package:Aanya/widgets/enlargeable_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<Widget> buildRecentActivites() {
  final userManagement = Get.find<UserManagement>();
  print("Build Recent Called");
  List<Widget> recentActivitiesWidget = [];
  for (var entry in userManagement.recent_activites) {
    // Adding Prompt
    recentActivitiesWidget.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical: 20 * fem),
        margin: EdgeInsets.fromLTRB(30 * fem, 10 * fem, 10 * fem, 0),
        decoration: BoxDecoration(
          color: Color.fromARGB(40, 255, 255, 255),
          borderRadius: BorderRadius.all(
            Radius.circular(10 * fem),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 220 * fem),
                  child: Text(
                    entry['prompt'],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16 * fem,
                    ),
                  ),
                ),
                Column(
                  children: [
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
              ],
            ),
            entry['desc_image_path'] != "null"
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15 * fem, vertical: 10 * fem),
                      width: 200 * fem,
                      height: 200 * fem,
                      child: Image.network(
                        userManagement.getImageURL(entry['desc_image_path']),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
    // Adding Response
    recentActivitiesWidget.add(Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical: 20 * fem),
      margin: EdgeInsets.fromLTRB(10 * fem, 10 * fem, 30 * fem, 0),
      decoration: BoxDecoration(
        color: Color.fromARGB(40, 129, 102, 247),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 220 * fem),
                child: Text(
                  entry['response'],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16 * fem,
                  ),
                ),
              ),
              entry['gen_image_path'] != "null"
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 10 * fem),
                      width: 200 * fem,
                      height: 200 * fem,
                      child: EnlargeableImage(
                        image: NetworkImage(
                          userManagement.getImageURL(entry['gen_image_path']),
                        ),
                      ))
                  : Container(),
            ],
          ),
        ],
      ),
    ));
  }
  return recentActivitiesWidget;
}
