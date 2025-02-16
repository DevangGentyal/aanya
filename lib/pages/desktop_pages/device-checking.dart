import 'dart:io';
import 'dart:ui';
import 'package:Aanya/database/user_management.dart';
import 'package:Aanya/init_checks.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/utils/get_device_info.dart';
import 'package:Aanya/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:Aanya/common_vars.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DesktopDeviceChecking extends StatelessWidget {
  Widget sceneBuilder(String sceneName, String device_name) {
    if (sceneName == "first-login") {
      return FirstLogin();
    } else if (sceneName == 'new-login') {
      return NewLogin();
    } else if (sceneName == 'waiting') {
      return WaitingScene(
        device_name: device_name,
      );
    } else if (sceneName == 'full-devices') {
      return DevicesFull();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    reciver_context = context;
    // Extract the arguments
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, -1),
              end: Alignment(0, 1),
              colors: <Color>[
                Color.fromRGBO(4, 1, 24, 1),
                Color.fromARGB(255, 48, 44, 102)
              ],
              stops: <double>[0, 1],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 1000 * width_fem,
                top: 600 * height_fem,
                child: Align(
                  child: SizedBox(
                    width: 500 * width_fem,
                    height: 500 * height_fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(107 * fem),
                        gradient: const RadialGradient(
                          center: Alignment(0, 0),
                          radius: 0.5,
                          colors: <Color>[
                            Color.fromARGB(188, 211, 153, 250),
                            Color.fromARGB(0, 212, 153, 250)
                          ],
                          stops: <double>[0, 0.9],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -50 * fem,
                top: 50 * fem,
                child: Align(
                  child: SizedBox(
                    width: 400 * width_fem,
                    height: 400 * height_fem,
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
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: 50 * fem, horizontal: 100 * fem),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(15, 255, 255, 255),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 100 * width_fem,
                            vertical: 100 * height_fem),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          child: sceneBuilder(
                              args?['scene'], args?['device-name']),
                        ),
                      ),
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

class FirstLogin extends StatefulWidget {
  @override
  State<FirstLogin> createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> {
  var user_management = Get.find<UserManagement>();
  final formKey = GlobalKey<FormState>();
  String? selectedGender;
  int age = 0;
  List<String> selectedInterests = [];
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
  @override
  Widget build(BuildContext context) {
    reciver_context = context;

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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Color.fromARGB(0, 255, 0, 0),
            child: Text(
              "About Yourself",
              style: GoogleFonts.oleoScriptSwashCaps(
                fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 255, 171, 171),
                fontSize: 50 * fem,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10, // Adjust the glow strength as needed
                    color: Color.fromARGB(171, 255, 171, 171),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 400 * fem,
          child: SingleChildScrollView(
            child: Container(
              height: 400 * fem,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Age Input
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        labelText: "Age",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(213, 255, 255, 255),
                          fontSize: 14 * ffem,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(234, 255, 255, 255),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(220, 255, 255, 255),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 14 * ffem,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your age';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        age = int.parse(value);
                      },
                    ),
                    // Gender Input
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        labelText: "Gender",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(213, 255, 255, 255),
                          fontSize: 14 * ffem,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(234, 255, 255, 255),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(220, 255, 255, 255),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 254, 254),
                        decoration: TextDecoration.none,
                        fontSize: 14 * ffem,
                      ),
                      dropdownColor: Color.fromARGB(255, 7, 11, 62),
                      value: selectedGender,
                      items: ['Male', 'Female']
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    // Interests Input
                    Text(
                      'Interests',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    Wrap(
                      children: buildInterestCheckboxes(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 150 * fem,
          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                // Saving user data
                await user_management.updateUserInfo('age', age.toString());
                await user_management.updateUserInfo('gender', selectedGender!);
                await user_management.updateUserInfo(
                    'interests', selectedInterests.toString());
                Navigator.pushReplacementNamed(context, '/device-checking',
                    arguments: {'scene': 'new-login', 'device-name': ''});
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 10, 8, 41),
                padding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Continue",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 16.0 * fem,
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
    );
  }
}

class NewLogin extends StatefulWidget {
  @override
  State<NewLogin> createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  var userManagement = Get.find<UserManagement>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController deviceNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    reciver_context = context;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Color.fromARGB(0, 255, 0, 0),
                child: Text(
                  "New Login ",
                  style: GoogleFonts.oleoScriptSwashCaps(
                    fontStyle: FontStyle.italic,
                    color: const Color.fromARGB(255, 255, 171, 171),
                    fontSize: 80 * fem,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10, // Adjust the glow strength as needed
                        color: Color.fromARGB(171, 255, 171, 171),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30 * fem),
              child: Text(
                "device detected",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40 * fem,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: 150 * width_fem,
              height: 100 * height_fem,
              child: Image.asset(
                "assets/images/animated-favicon-2.gif",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Enter ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40 * fem,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "Device Name ",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontFamily: "serif",
                  color: const Color.fromARGB(255, 255, 171, 171),
                  fontSize: 40 * fem,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "to Continue",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40 * fem,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 50 * height_fem, right: 200 * width_fem),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: formKey,
                  child: MyInputField(
                      placeholder: "Device Name",
                      controller: deviceNameController,
                      validatorCallback: ValidationBuilder()
                          .minLength(5)
                          .maxLength(20)
                          .build(),
                      obscureText: false),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100 * height_fem),
                  width: 200 * width_fem,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Save Device Info to database and switch to HomePage

                      if (formKey.currentState!.validate()) {
                        await userManagement.addDevice(
                            deviceNameController.text,
                            await getCurrentDeviceIp(),
                            await getCurrentDeviceId());
                        // widget.first_login
                        //     ? Navigator.pushNamed(context, '/about-user')
                        // :h
                        await initChecks(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 10, 8, 41),
                        padding: EdgeInsets.all(20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Continue",
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WaitingScene extends StatelessWidget {
  final String device_name;
  const WaitingScene({
    super.key,
    required this.device_name,
  });
  @override
  Widget build(BuildContext context) {
    var userManagement = Get.find<UserManagement>();
    reciver_context = context;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Color.fromARGB(0, 255, 0, 0),
                child: Text(
                  "Aanya ",
                  style: GoogleFonts.oleoScriptSwashCaps(
                    fontStyle: FontStyle.italic,
                    color: const Color.fromARGB(255, 255, 171, 171),
                    fontSize: 80 * fem,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10, // Adjust the glow strength as needed
                        color: Color.fromARGB(171, 255, 171, 171),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                "is currently Occupied!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40 * fem,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: 150 * width_fem,
              height: 100 * height_fem,
              child: Image.asset(
                "assets/images/animated-favicon-2.gif",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Please ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40 * fem,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "Switch ",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontFamily: "serif",
                  color: const Color.fromARGB(255, 255, 171, 171),
                  fontSize: 40 * fem,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "to Continue",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40 * fem,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 100 * height_fem),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Text(
                  "Say ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24 * fem,
                  ),
                ),
                Text(
                  "\"Aanya switch to $device_name\"",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 171, 171),
                    fontSize: 24 * fem,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50 * height_fem),
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: () async {
              await userManagement.updateUserInfo(
                  "active_device", await getCurrentDeviceId());
              Navigator.pushReplacementNamed(context, '/home');
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(30 * fem),
                backgroundColor: Color.fromARGB(255, 10, 8, 41)),
            child: Text(
              "Force Push",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class DevicesFull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    reciver_context = context;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Color.fromARGB(0, 255, 0, 0),
                child: Text(
                  "Capacity Reached ",
                  style: GoogleFonts.oleoScriptSwashCaps(
                    fontStyle: FontStyle.italic,
                    color: const Color.fromARGB(255, 255, 171, 171),
                    fontSize: 80 * fem,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10, // Adjust the glow strength as needed
                        color: Color.fromARGB(171, 255, 171, 171),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 150 * width_fem,
              height: 100 * height_fem,
              child: Image.asset(
                "assets/images/animated-favicon-2.gif",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 800 * width_fem),
              child: Text(
                softWrap: true,
                "You have reached maximum number of Devices for your Ecosystem.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40 * fem,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 100 * height_fem),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Text(
                  "Try removing a device.",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 182, 182),
                    fontSize: 24 * fem,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
