import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/widgets/ellipse.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:Aanya/modules/image_desc_api.dart';
import 'package:Aanya/modules/text_to_speech.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Aanya/common_vars.dart';
import 'package:provider/provider.dart';

class DesktopImageDesc extends StatefulWidget {
  @override
  State<DesktopImageDesc> createState() => _DesktopImageDescState();
}

class _DesktopImageDescState extends State<DesktopImageDesc> {
  bool _imageSelected = false;
  String _description = 'Select an image to describe';
  // Define a variable to hold the selected image
  File? _selectedImage;
  @override
  void initState() {
    super.initState();
    initTTS();
  }

  void _getImageAndSendDescription(
      String query, CommonVariables commonVariables) async {
    flutterTts.stop();
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    String description = "";
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _imageSelected = true;
        _description = 'Proccessing...';
      });
      // Send image to the API and get description
      if (_selectedImage != null) {
        description = await imageDescAPI(_selectedImage!, query);
      } else {
        print('No image provided');
      }
    }
    setState(() {
      _description = description;
    });
    desktopTTS(description);
  }

  @override
  Widget build(BuildContext context) {
    final commonVars = Provider.of<CommonVariables>(context);
    reciver_context = context;
    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(4, 1, 24, 1),
        ),
        child: Stack(
          children: [
            // Lights Elipse

            Ellipse(
              left: 1250 * width_fem,
              top: 40 * height_fem,
              width: 300 * width_fem,
              height: 300 * height_fem,
              innerColor: Color.fromARGB(99, 150, 0, 244),
              outerColor: Color.fromARGB(
                0,
                151,
                0,
                244,
              ),
            ),
            // Body
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Left Side
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Status Box
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20 * width_fem,
                            vertical: 10 * height_fem),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff8ebbff)),
                          color: Color(0x56494c89),
                          borderRadius: BorderRadius.circular(20 * width_fem),
                        ),
                        child: Center(
                          child: Text(
                            commonVars.aanyaStatus,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20 * fwidth_fem,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff8ebbff),
                            ),
                          ),
                        ),
                      ),
                      // Aanya Model
                      Container(
                        width: 500 * width_fem,
                        height: 800 * height_fem,
                        child: ClipRRect(
                          child: Image.asset(
                            "assets/images/aanya-temp.png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Right Side
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image View with stars
                      Container(
                        margin: EdgeInsets.only(
                            top: 0 * height_fem,
                            left: 30 * width_fem,
                            right: 30 * width_fem),
                        width: 800 * width_fem,
                        height: 500 * width_fem,
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 1000),
                              left: _imageSelected
                                  ? 0 * width_fem
                                  : 200 * width_fem,
                              top: _imageSelected
                                  ? 250 * height_fem
                                  : 200 * width_fem,
                              child: SizedBox(
                                width: 100 * width_fem,
                                height: 130 * height_fem,
                                child: Image.asset(
                                  'assets/images/animated-favicon-2.gif',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 1000),
                              left: _imageSelected
                                  ? 700 * width_fem
                                  : 500 * width_fem,
                              top: _imageSelected
                                  ? 20 * height_fem
                                  : 150 * height_fem,
                              child: SizedBox(
                                width: 100 * width_fem,
                                height: 80 * height_fem,
                                child: Image.asset(
                                  'assets/images/animated-favicon-2.gif',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Center(
                              child: Stack(
                                children: [
                                  Visibility(
                                    visible: _imageSelected ? false : true,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _getImageAndSendDescription(
                                            commonVars.recognizedWords,
                                            commonVars);
                                        commonVars
                                            .updateAanyaStatus("Processing");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 20 * height_fem,
                                          horizontal: 30 * width_fem,
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(110, 164, 167, 255),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    10 * width_fem))),
                                      ),
                                      child: Text(
                                        "Choose Image",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20 * width_fem),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _imageSelected ? true : false,
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: (() {
                                          _getImageAndSendDescription(
                                              commonVars.recognizedWords,
                                              commonVars);
                                          commonVars
                                              .updateAanyaStatus("Processing");
                                        }),
                                        child: Container(
                                          width: 500 * width_fem,
                                          height: 300 * height_fem,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    30 * width_fem)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    30 * width_fem)),
                                            child: _selectedImage != null &&
                                                    File(_selectedImage!.path)
                                                        .existsSync()
                                                ? Image.file(
                                                    _selectedImage!,
                                                    fit: BoxFit.contain,
                                                  )
                                                : Image.network(
                                                    "https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg",
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
                      // Text View
                      Container(
                        height: 200 * height_fem,
                        margin: EdgeInsets.only(
                            left: 20 * width_fem,
                            right: 20 * width_fem,
                            bottom: 20 * width_fem),
                        constraints: BoxConstraints(maxWidth: 500 * width_fem),
                        child: SingleChildScrollView(
                          child: Text(
                            _description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30 * width_fem,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Ellipse(
              left: 130 * width_fem,
              top: 700 * height_fem,
              width: 300 * width_fem,
              height: 300 * height_fem,
              innerColor: Color.fromARGB(144, 211, 153, 250),
              outerColor: Color.fromARGB(0, 211, 153, 250),
            ),
            Ellipse(
              left: -100 * width_fem,
              top: 0 * height_fem,
              width: 200 * width_fem,
              height: 200 * height_fem,
              innerColor: Color.fromARGB(176, 211, 153, 250),
              outerColor: Color.fromARGB(0, 211, 153, 250),
            ),
          ],
        ),
      ),
    );
  }
}
