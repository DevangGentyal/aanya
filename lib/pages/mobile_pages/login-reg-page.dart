import 'dart:io';
import 'package:Aanya/widgets/ellipse.dart';
import 'package:flutter/material.dart';
import 'package:Aanya/database/storage_service.dart';
import 'package:Aanya/database/auth_Controller.dart';
import 'package:get/get.dart';
import 'package:Aanya/widgets/input_field.dart';
import 'package:Aanya/common_vars.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:form_validator/form_validator.dart';

class MobileLoginReg extends StatefulWidget {
  MobileLoginRegState createState() => MobileLoginRegState();
}

class MobileLoginRegState extends State<MobileLoginReg> {
  bool loginVisible = true;

  final AuthController authcontroller = Get.put(AuthController());

  // GlobalKeys for identifying forms individually
  static GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();
  static GlobalKey<FormState> _registerformKey = GlobalKey<FormState>();

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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        exit(0);
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              // loginpage
              width: double.infinity,
              height: 800 * fem,
              decoration: BoxDecoration(
                color: Color.fromRGBO(36, 41, 61, 1),
              ),
              child: Stack(
                children: [
                  Ellipse(
                    left: -120 * fem,
                    top: 398 * fem,
                    width: 327 * fem,
                    height: 327 * fem,
                    innerColor: Color.fromARGB(171, 97, 95, 243),
                    outerColor: Color.fromARGB(0, 83, 82, 159),
                    radius: 0.4,
                  ),
                  Ellipse(
                    left: -137 * fem,
                    top: 558 * fem,
                    width: 460 * fem,
                    height: 460 * fem,
                    innerColor: Color.fromARGB(255, 255, 158, 161),
                    outerColor: Color.fromARGB(0, 255, 158, 161),
                    radius: 0.45,
                  ),
                  Ellipse(
                    left: 25 * fem,
                    top: -258 * fem,
                    width: 460 * fem,
                    height: 460 * fem,
                    innerColor: Color.fromARGB(255, 255, 158, 161),
                    outerColor: Color.fromARGB(0, 255, 158, 161),
                    radius: 0.45,
                  ),
                  Ellipse(
                    left: 202 * fem,
                    top: 51 * fem,
                    width: 206 * fem,
                    height: 206 * fem,
                    innerColor: Color.fromARGB(230, 97, 95, 243),
                    outerColor: Color.fromARGB(0, 83, 82, 159),
                    radius: 0.5,
                  ),
                  Positioned(
                    // aanyaa logo
                    left: 60 * fem,
                    top: 127 * fem,
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
                  // OutlineForm 
                  Positioned(
                    left: 36 * fem,
                    top: loginVisible ? 219 * fem : 219 * fem,
                    child: AnimatedSize(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              2 * fem, 2 * fem, 2 * fem, 20 * fem),
                          width: 289 * fem,
                          decoration: BoxDecoration(
                            color: Color(0x1e8ebbff),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18 * fem)),
                            border: Border.all(
                                color: Color.fromARGB(225, 255, 190, 185)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Login/Register Button Group
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 45 * fem),
                                width: double.infinity,
                                height: 46 * fem,
                                child: Row(
                                  children: [
                                    // Login Button
                                    Container(
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
                                          width: 141 * fem,
                                          height: 46 * fem,
                                          decoration: BoxDecoration(
                                            color: loginVisible
                                                ? Color.fromARGB(0, 17, 76, 255)
                                                : Color.fromRGBO(
                                                    62, 72, 102, 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(18 * fem),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                fontSize: 20 * ffem,
                                                fontWeight: FontWeight.w700,
                                                height: 1.2125 * ffem / fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Register Button
                                    Container(
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
                                          width: 141 * fem,
                                          height: 46 * fem,
                                          decoration: BoxDecoration(
                                            color: loginVisible
                                                ? Color.fromRGBO(62, 72, 102, 1)
                                                : Color.fromARGB(
                                                    0, 17, 76, 255),
                                            borderRadius: BorderRadius.only(
                                              topRight:
                                                  Radius.circular(18 * fem),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Register',
                                              style: TextStyle(
                                                fontSize: 20 * ffem,
                                                fontWeight: FontWeight.w700,
                                                height: 1.2125 * ffem / fem,
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
                                        duration: Duration(milliseconds: 500))
                                  ],
                                  child: Form(
                                    key: _loginformKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10 * fem),
                                          child: MyInputField(
                                            placeholder: "Email",
                                            controller: emailLoginController,
                                            obscureText: false,
                                            validatorCallback:
                                                ValidationBuilder()
                                                    .email()
                                                    .build(),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10 * fem),
                                          child: MyInputField(
                                            placeholder: "Password",
                                            controller: passwordLoginController,
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

                              // Register Form
                              Visibility(
                                visible: !loginVisible,
                                child: Animate(
                                  effects: [
                                    FadeEffect(
                                        duration: Duration(milliseconds: 500))
                                  ],
                                  child: Container(
                                    height: 340,
                                    child: SingleChildScrollView(
                                      child: Form(
                                        key: _registerformKey,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(10 * fem),
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
                                              margin: EdgeInsets.all(10 * fem),
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
                                              margin: EdgeInsets.all(10 * fem),
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
                                              margin: EdgeInsets.all(10 * fem),
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
                                              margin: EdgeInsets.all(10 * fem),
                                              child: MyInputField(
                                                placeholder: "Confirm Password",
                                                controller:
                                                    confirmpassRegisterController,
                                                obscureText: true,
                                                validatorCallback: (value) {
                                                  if (passwordRegisterController
                                                          .text !=
                                                      confirmpassRegisterController
                                                          .text) {
                                                    return "Confirm Password dosen't Match";
                                                  }
                                                  return null;
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
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 10 * fem, 0 * fem, 20 * fem),
                                width: double.infinity,
                                height: 34 * fem,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      // submitbutton33r (15:50)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                      child: Obx(
                                        () => ElevatedButton(
                                          onPressed: () async {
                                            // First Check which form is Enabled
                                            if (StorageService.getUserSession !=
                                                null) {
                                              // Do nothing
                                            } else if (loginVisible) {
                                              // Validation confirm for Login Form
                                              if (_loginformKey.currentState!
                                                      .validate() &&
                                                  authcontroller
                                                          .loginLoading.value ==
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
                                                  _loginformKey.currentState!
                                                      .reset();
                                                  Navigator.pushNamed(context,
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
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // Close the dialog
                                                              },
                                                              child: Text("OK"),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                }
                                              }
                                            } else {
                                              // Validation confirm for Register Form
                                              if (_registerformKey.currentState!
                                                      .validate() &&
                                                  authcontroller.signupLoading
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
                                                _registerformKey.currentState!
                                                    .reset();

                                                if (SignupRes == 'success') {
                                                  Navigator.pushNamed(context,
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
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // Close the dialog
                                                              },
                                                              child: Text("OK"),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                }
                                              }
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: Container(
                                            width: 99 * fem,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0xffff9ea1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10 * fem),
                                            ),
                                            child: Center(
                                              child: Text(
                                                style: TextStyle(
                                                  fontSize: 12 * ffem,
                                                  fontWeight: FontWeight.w800,
                                                  height: 1.2125 * ffem / fem,
                                                  color: Color(0xff3e4866),
                                                ),
                                                authcontroller.signupLoading
                                                            .value ||
                                                        authcontroller
                                                            .loginLoading.value
                                                    ? "Loading.."
                                                    : "Submit",
                                                textAlign: TextAlign.center,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // authcontroller.dispose();
    emailLoginController.dispose();
    passwordLoginController.dispose();
    emailRegisterController.dispose();
    usernameRegisterController.dispose();
    phoneRegisterController.dispose();
    passwordRegisterController.dispose();
    confirmpassRegisterController.dispose();
    super.dispose();
  }
}
