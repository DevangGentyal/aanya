import 'package:Aanya/database/user_management.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/utils/recent_activities.dart';
import 'package:Aanya/widgets/input_field.dart';
import 'package:Aanya/common_vars.dart';
import 'package:flutter/material.dart';

import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class DesktopUserProfile extends StatefulWidget {
  @override
  State<DesktopUserProfile> createState() => DesktopUserProfileState();
}

class DesktopUserProfileState extends State<DesktopUserProfile> {
  bool basicVisible = true;
  bool additionalVisible = false;
  bool recentVisible = false;
  String _selectedGender = "Male";
  // GlobalKeys for identifying forms individually
  static GlobalKey<FormState> basicFormKey = GlobalKey<FormState>();

  static TextEditingController usernameController =
      TextEditingController(text: "");
  static TextEditingController emailController =
      TextEditingController(text: "");
  static TextEditingController phoneController =
      TextEditingController(text: "");
  static TextEditingController ageController = TextEditingController(text: "");

  var userManagement = Get.find<UserManagement>();
  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  void fetchDetails() {
    try{
    usernameController.text = userManagement.name.value;
    emailController.text = userManagement.email.value;
    phoneController.text = userManagement.phone_no.value;
    ageController.text = userManagement.age.value;
    _selectedGender = userManagement.gender.value;
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    reciver_context = context;
    List<String> selectedInterests = userManagement.interests.value
        .substring(1, userManagement.interests.value.length - 1)
        .split(', ');
    List<String> commonInterests = [
      'Sports',
      'Music',
      'Movies',
      'Reading',
      'Cooking',
      'Traveling',
      'Gaming',
      'Art and Creativity',
      'Fitness',
      'Technology',
      'Fashion and Style',
      'History and Culture',
    ];
    List<Widget> buildInterestCheckboxes() {
      List<Widget> checkboxes = [];
      for (String interest in commonInterests) {
        checkboxes.add(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                activeColor: const Color.fromARGB(255, 255, 184, 184),
                checkColor: Colors.black,
                value: selectedInterests.contains(interest),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedInterests.add(interest);
                    } else {
                      selectedInterests.remove(interest);
                    }
                  });
                },
              ),
              Text(
                interest,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      }
      return checkboxes;
    }

    return Scaffold(
      body: Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color.fromRGBO(4, 1, 24, 1),
          ),
          child: Stack(
            children: [
              Positioned(
                // ellipse43Tr (15:26)
                left: 0 * fem,
                top: -160 * fem,
                child: Align(
                  child: SizedBox(
                    width: screen_width,
                    height: 400 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500 * fem),
                        gradient: const RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.6,
                          colors: <Color>[
                            Color.fromARGB(121, 114, 0, 244),
                            Color.fromARGB(0, 89, 0, 255)
                          ],
                          stops: <double>[0, 0.75],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // ellipse43Tr (15:26)
                left: 570 * fem,
                top: -150 * fem,
                child: Align(
                  child: SizedBox(
                    width: 300 * fem,
                    height: 300 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(530 * fem),
                        gradient: const RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.8,
                          colors: <Color>[
                            Color.fromARGB(103, 255, 165, 165),
                            Color.fromARGB(0, 255, 179, 179)
                          ],
                          stops: <double>[0, 0.45],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // ellipse43Tr (15:26)
                left: -120 * fem,
                top: 300,
                child: Align(
                  child: SizedBox(
                    width: 200 * fem,
                    height: 300 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(530 * fem),
                        gradient: const RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.8,
                          colors: <Color>[
                            Color.fromARGB(48, 255, 165, 165),
                            Color.fromARGB(0, 255, 179, 179)
                          ],
                          stops: <double>[0, 0.45],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    // Header Section
                    Container(
                      width: double.infinity,
                      height: 220 * fem,
                      // color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // User PFP
                          Container(
                            margin: EdgeInsets.all(10 * fem),
                            child: Image.asset(
                              'assets/images/user.png',
                              height: 80 * fem,
                            ),
                          ),
                          // Full Name
                          Container(
                            child: Text(
                              usernameController.text,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Tabs Section
                    Container(
                      margin: EdgeInsets.only(top: 20 * height_fem),
                      width: screen_width - 500,
                      height: 50 * fem,
                      // color: Colors.teal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // First Tab
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  basicVisible = true;
                                  additionalVisible = false;
                                  recentVisible = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: basicVisible
                                      ? Color.fromARGB(255, 184, 181, 255)
                                      : Color.fromARGB(255, 31, 33, 69),
                                  padding: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: Row(children: [
                                Text(
                                  "Basic Info",
                                  style: TextStyle(
                                    color: basicVisible
                                        ? Color.fromARGB(255, 31, 33, 69)
                                        : Color.fromARGB(255, 184, 181, 255),
                                    fontSize: 14.0 * fem,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          // Second Tab
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  additionalVisible = true;
                                  basicVisible = false;
                                  recentVisible = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: additionalVisible
                                      ? Color.fromARGB(255, 184, 181, 255)
                                      : Color.fromARGB(255, 31, 33, 69),
                                  padding: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: Row(children: [
                                Text(
                                  "Additional",
                                  style: TextStyle(
                                    color: additionalVisible
                                        ? Color.fromARGB(255, 31, 33, 69)
                                        : Color.fromARGB(255, 184, 181, 255),
                                    fontSize: 14.0 * fem,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          // Third Tab
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  recentVisible = true;
                                  basicVisible = false;
                                  additionalVisible = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: recentVisible
                                      ? Color.fromARGB(255, 184, 181, 255)
                                      : Color.fromARGB(255, 31, 33, 69),
                                  padding: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: Row(children: [
                                Text(
                                  "Recent Activites",
                                  style: TextStyle(
                                    color: recentVisible
                                        ? Color.fromARGB(255, 31, 33, 69)
                                        : Color.fromARGB(255, 184, 181, 255),
                                    fontSize: 14.0 * fem,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Body Section
                    Container(
                      height: 500 * fem,
                      padding: EdgeInsets.symmetric(
                          vertical: 50 * fem, horizontal: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Basic Info Form
                            Visibility(
                              visible: basicVisible,
                              child: Form(
                                key: basicFormKey,
                                child: Column(
                                  children: [
                                    Container(
                                      // username Input
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              'Username',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 142, 143, 219)),
                                            ),
                                          ),
                                          MyInputField(
                                            placeholder: "",
                                            controller: usernameController,
                                            validatorCallback:
                                                ValidationBuilder().build(),
                                            obscureText: false,
                                            enabled: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // Email Input
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              'Email',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 142, 143, 219)),
                                            ),
                                          ),
                                          MyInputField(
                                            placeholder: "",
                                            controller: emailController,
                                            validatorCallback:
                                                ValidationBuilder().build(),
                                            obscureText: false,
                                            enabled: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // Phone Input
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              'Phone',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 142, 143, 219)),
                                            ),
                                          ),
                                          MyInputField(
                                            placeholder: "",
                                            controller: phoneController,
                                            validatorCallback:
                                                ValidationBuilder().build(),
                                            obscureText: false,
                                            enabled: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // Age Input
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              'Age',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 142, 143, 219)),
                                            ),
                                          ),
                                          MyInputField(
                                            placeholder: "",
                                            controller: ageController,
                                            validatorCallback:
                                                ValidationBuilder().build(),
                                            obscureText: false,
                                            enabled: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // Gender Input
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              'Gender',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 142, 143, 219)),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10 * ffem,
                                                horizontal: 10 * ffem),
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: _selectedGender,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedGender = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'Male',
                                                'Female',
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                labelStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      207, 255, 255, 255),
                                                  fontSize: 12 * ffem,
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        96, 255, 255, 255),
                                                    width: 1,
                                                    style: BorderStyle.solid,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        96, 255, 255, 255),
                                                    width: 1,
                                                    style: BorderStyle.solid,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        96, 255, 255, 255),
                                                    width: 1,
                                                    style: BorderStyle.solid,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              dropdownColor: Color.fromARGB(
                                                  255, 42, 15, 87),
                                              style: TextStyle(
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontSize: 16 * ffem,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Additional Form
                            Visibility(
                              visible: additionalVisible,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 20 * fem),
                                      child: Text(
                                        'Interests',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Wrap(
                                        spacing: 20,
                                        children: buildInterestCheckboxes(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Recent Activites
                            Visibility(
                              visible: recentVisible,
                              child: Container(
                                child: Column(children: buildRecentActivites()),
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
      ),
    );
  }
}
