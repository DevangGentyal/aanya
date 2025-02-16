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

class MobileDeviceChecking extends StatefulWidget {
  @override
  State<MobileDeviceChecking> createState() => _MobileDeviceCheckingState();
}

class _MobileDeviceCheckingState extends State<MobileDeviceChecking> {
  static String sceneName = '';
  String deviceName = '';

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
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    setState(() {
      sceneName = args?['scene'];
      deviceName = args?['device-name'];
      reciver_context = context;
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          height: screen_height,
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
                // Body
                Container(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10 * fem),
                      height: 500 * fem,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50 * width_fem,
                                vertical: 50 * height_fem),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(15, 255, 255, 255),
                              border: Border.all(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20 * fem, vertical: 20 * fem),
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: sceneBuilder(sceneName, deviceName),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                fontSize: 30 * fem,
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
          height: 200 * fem,
          child: SingleChildScrollView(
            child: Container(
              height: 500 * fem,
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
                          fontSize: 12 * ffem,
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
                          fontSize: 12 * ffem,
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
                      dropdownColor: Color.fromARGB(255, 105, 108, 160),
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
  State<NewLogin> createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final userManagement = Get.find<UserManagement>();
  final TextEditingController deviceNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    reciver_context = context;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                fontSize: 30 * fem,
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
          constraints: BoxConstraints(maxWidth: 200 * fem),
          child: Text(
            softWrap: true,
            "device detected",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20 * fem,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10 * fem),
                child: Row(
                  children: [
                    Text(
                      "Enter ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Device Name ",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontFamily: "serif",
                          color: const Color.fromARGB(255, 255, 171, 171),
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "to Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                child: MyInputField(
                    placeholder: "Device Name",
                    controller: deviceNameController,
                    validatorCallback:
                        ValidationBuilder().minLength(5).maxLength(20).build(),
                    obscureText: false),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20 * fem),
                width: 150 * fem,
                child: ElevatedButton(
                  onPressed: () async {
                    // Save Device Info to database and switch to HomePage
                    if (formKey.currentState!.validate()) {
                      await userManagement.addDevice(
                        deviceNameController.text,
                        await getCurrentDeviceIp(),
                        await getCurrentDeviceId(),
                      );
                      await initChecks(context);
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                fontSize: 30 * fem,
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
          constraints: BoxConstraints(maxWidth: 200 * fem),
          child: Text(
            softWrap: true,
            "is Occupied!",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20 * fem,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10 * fem),
          child: Row(
            children: [
              Text(
                "Please ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 * fem,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "Switch ",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontFamily: "serif",
                    color: const Color.fromARGB(255, 255, 171, 171),
                    fontSize: 18 * fem,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "to Continue",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16 * fem,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20 * fem),
          child: Row(
            children: [
              Text(
                "Say ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14 * fem,
                ),
              ),
              Text(
                "\"Aanya switch to $device_name\"",
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 171, 171),
                  fontSize: 14 * fem,
                ),
              ),
            ],
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
                padding: EdgeInsets.all(20 * fem),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50 * fem, vertical: 2 * fem),
          child: Row(
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
                      fontSize: 30 * fem,
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
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50 * fem, vertical: 2 * fem),
          child: Row(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 200 * fem),
                child: Text(
                  softWrap: true,
                  "You have reached maximum number of Devices for your Ecosystem. ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18 * fem,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: 50 * fem, vertical: 40 * fem),
          child: Row(
            children: [
              Text(
                "Try removing a Device.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14 * fem,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
