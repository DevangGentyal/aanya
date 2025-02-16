import 'dart:io';
import 'dart:ui';
import 'package:Aanya/common_vars.dart';
import 'package:Aanya/database/auth_controller.dart';
import 'package:Aanya/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class DesktopLoginReg extends StatefulWidget {
  DesktopLoginRegState createState() => DesktopLoginRegState();
}

class DesktopLoginRegState extends State<DesktopLoginReg> {
  bool loginVisible = true;

  final AuthController authcontroller = Get.put(AuthController());

  // GlobalKeys for identifying forms individually
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerformKey = GlobalKey<FormState>();

  // TextEditing Controllers for form
  final TextEditingController emailLoginController =
      TextEditingController(text: "");
  final TextEditingController passwordLoginController =
      TextEditingController(text: "");

  final TextEditingController usernameRegisterController =
      TextEditingController(text: "");
  final TextEditingController emailRegisterController =
      TextEditingController(text: "");
  final TextEditingController phoneRegisterController =
      TextEditingController(text: "");
  final TextEditingController passwordRegisterController =
      TextEditingController(text: "");
  final TextEditingController confirmpassRegisterController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
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
            onPressed: ()async {
              exit(0);
            },
          ),
        ],
        toolbarHeight: 30,
        backgroundColor: Color.fromRGBO(4, 1, 24, 1),
      ),
      body: Expanded(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, -1),
              end: Alignment(0, 1),
              colors: <Color>[
                Color.fromRGBO(4, 1, 24, 1),
                Color.fromARGB(255, 53, 50, 100)
              ],
              stops: <double>[0, 1],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                // ellipse1agk (15:19)
                left: 900 * fem,
                top: 400 * fem,
                child: Align(
                  child: SizedBox(
                    width: 460 * fem,
                    height: 460 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(230 * fem),
                        gradient: const RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.45,
                          colors: <Color>[
                            Color.fromARGB(123, 255, 158, 161),
                            Color.fromARGB(0, 255, 158, 161)
                          ],
                          stops: <double>[0, 0.8],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // ellipse2LXW (15:24)
                left: 900 * fem,
                top: 600 * fem,
                child: Align(
                  child: SizedBox(
                    width: 327 * fem,
                    height: 327 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(203.5 * fem),
                        gradient: const RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.4,
                          colors: <Color>[
                            Color.fromARGB(213, 97, 95, 243),
                            Color.fromARGB(0, 83, 82, 159)
                          ],
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // ellipse3df2 (15:25)
                left: 100 * fem,
                top: 100 * fem,
                child: Align(
                  child: SizedBox(
                    width: 460 * fem,
                    height: 460 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(230 * fem),
                        gradient: const RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.45,
                          colors: <Color>[
                            Color.fromARGB(172, 255, 158, 161),
                            Color.fromARGB(0, 255, 158, 161)
                          ],
                          stops: <double>[0, 0.8],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // ellipse43Tr (15:26)
                left: 250 * fem,
                top: 50 * fem,
                child: Align(
                  child: SizedBox(
                    width: 206 * fem,
                    height: 206 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(230 * fem),
                        gradient: const RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.5,
                          colors: <Color>[
                            Color.fromARGB(230, 97, 95, 243),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Logo
                    Container(
                      child: Align(
                        child: SizedBox(
                          width: 250 * fem,
                          height: 80 * fem,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    // Outline Form
                    Container(
                      margin: EdgeInsets.only(top: 20 * fem),
                      child: AnimatedSize(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                        child: Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18 * fem)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    2 * fem, 2 * fem, 2 * fem, 20 * fem),
                                width: 700 * fem,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(33, 142, 187, 255),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(18 * fem)),
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(225, 255, 190, 185)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Login/Register Button Group
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 45 * fem),
                                      width: double.infinity,
                                      height: 46 * fem,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Login Button (15:95)
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  loginVisible = true;
                                                });
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: loginVisible
                                                      ? Color.fromARGB(
                                                          0, 17, 76, 255)
                                                      : Color.fromRGBO(
                                                          96, 99, 176, 0.3),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        18 * fem),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Login',
                                                    style: TextStyle(
                                                      fontSize: 20 * ffem,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height:
                                                          1.2125 * ffem / fem,
                                                      color: Color(0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // registerbuttonr5r (15:95)
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  loginVisible = false;
                                                });
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: Container(
                                                height: 46 * fem,
                                                decoration: BoxDecoration(
                                                  color: loginVisible
                                                      ? Color.fromRGBO(
                                                          96, 99, 176, 0.3)
                                                      : Color.fromARGB(
                                                          0, 17, 76, 255),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        18 * fem),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Register',
                                                    style: TextStyle(
                                                      fontSize: 20 * ffem,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height:
                                                          1.2125 * ffem / fem,
                                                      color: Color(0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //
                                    //
                                    //
                                    // Login Form
                                    Visibility(
                                      visible: loginVisible,
                                      child: Animate(
                                        effects: [
                                          FadeEffect(
                                              duration:
                                                  Duration(milliseconds: 500))
                                        ],
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50 * fem),
                                          child: Form(
                                            key: _loginformKey,
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(10*fem),
                                                  child: MyInputField(
                                                    placeholder: "Email",
                                                    controller:
                                                        emailLoginController,
                                                    obscureText: false,
                                                    validatorCallback:
                                                        ValidationBuilder()
                                                            .email()
                                                            .build(),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(10*fem),
                                                  child: MyInputField(
                                                    placeholder: "Password",
                                                    controller:
                                                        passwordLoginController,
                                                    obscureText: true,
                                                    validatorCallback:
                                                        ValidationBuilder()
                                                            .minLength(8)
                                                            .maxLength(20)
                                                            .build(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Register Form
                                    Visibility(
                                      visible: !loginVisible,
                                      child: Animate(
                                        effects: [
                                          FadeEffect(
                                              duration:
                                                  Duration(milliseconds: 500))
                                        ],
                                        child: Container(
                                          height: 400 * fem,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50 * fem),
                                          child: SingleChildScrollView(
                                            child: Form(
                                              key: _registerformKey,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.all(10*fem),
                                                    child: MyInputField(
                                                      placeholder: "Username",
                                                      controller:
                                                          usernameRegisterController,
                                                      obscureText: false,
                                                      validatorCallback:
                                                          ValidationBuilder()
                                                              .minLength(5)
                                                              .maxLength(50)
                                                              .build(),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(10*fem),
                                                    child: MyInputField(
                                                      placeholder: "Email",
                                                      controller:
                                                          emailRegisterController,
                                                      obscureText: false,
                                                      validatorCallback:
                                                          ValidationBuilder()
                                                              .email()
                                                              .build(),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(10*fem),
                                                    child: MyInputField(
                                                      placeholder: "Phone",
                                                      controller:
                                                          phoneRegisterController,
                                                      obscureText: false,
                                                      validatorCallback:
                                                          ValidationBuilder()
                                                              .phone()
                                                              .build(),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(10*fem),
                                                    child: MyInputField(
                                                      placeholder: "Password",
                                                      controller:
                                                          passwordRegisterController,
                                                      obscureText: true,
                                                      validatorCallback:
                                                          ValidationBuilder()
                                                              .minLength(8)
                                                              .maxLength(20)
                                                              .build(),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(10*fem),
                                                    child: MyInputField(
                                                      placeholder:
                                                          "Confirm Password",
                                                      controller:
                                                          confirmpassRegisterController,
                                                      obscureText: true,
                                                      validatorCallback: (value) {
                                                        if (passwordRegisterController
                                                                .text !=
                                                            confirmpassRegisterController
                                                                .text) {
                                                          return "Confirm Password dosen't Match";
                                                        } else {
                                                          return null; // Return null when validation passes
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    //
                                    //
                                    // Submit Button
                                    Container(
                                      // Submit and Guest Button
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 10 * fem, 0 * fem, 20 * fem),
                                      width: double.infinity,
                                      // height: 34 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // submitbutton
                                          Container(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                // First Check which form is Enabled
                                                if (loginVisible) {
                                                  // Validation confirm for Login Form
                                                  if (_loginformKey
                                                          .currentState!
                                                          .validate() &&
                                                      authcontroller
                                                              .loginLoading
                                                              .value ==
                                                          false) {
                                                    print("good to go");

                                                    // Database Logging Checking
                                                    String loginRes =
                                                        await authcontroller.login(
                                                            emailLoginController
                                                                .text,
                                                            passwordLoginController
                                                                .text);

                                                    if (loginRes == 'success') {
                                                      // Clear all text field data
                                                      _loginformKey
                                                          .currentState!
                                                          .reset();
                                                      Navigator.pushNamed(
                                                          context,
                                                          "/loading_scene");
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Login Failed"),
                                                              content: Text(
                                                                  "Invalid email or password"),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(); // Close the dialog
                                                                  },
                                                                  child: Text(
                                                                      "OK"),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    }
                                                  }
                                                } else {
                                                  // Validation confirm for Register Form
                                                  if (_registerformKey
                                                          .currentState!
                                                          .validate() &&
                                                      authcontroller
                                                              .signupLoading
                                                              .value ==
                                                          false) {
                                                    print("good to go");

                                                    //DataBase Checking
                                                    String SignupRes =
                                                        await authcontroller.signup(
                                                            usernameRegisterController
                                                                .text,
                                                            emailRegisterController
                                                                .text,
                                                            passwordRegisterController
                                                                .text,
                                                            phoneRegisterController
                                                                .text);

                                                    // Clear all text field data
                                                    _registerformKey
                                                        .currentState!
                                                        .reset();

                                                    if (SignupRes ==
                                                        'success') {
                                                      Navigator.pushNamed(
                                                          context,
                                                          "/loading_scene");
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Signup Failed"),
                                                              content: Text(
                                                                  "Failed to create an account."),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(); // Close the dialog
                                                                  },
                                                                  child: Text(
                                                                      "OK"),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    }
                                                  }
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  foregroundColor:
                                                      const Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 255, 177, 177),
                                                  padding: EdgeInsets.all(20.0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  )),
                                              child: Text(
                                                "SUBMIT",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20 * ffem,
                                                  fontWeight: FontWeight.w800,
                                                  height: 1.2125 * ffem / fem,
                                                  color: Color(0xff3e4866),
                                                ),
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
                          ),
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
