import 'dart:async';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/pages/mobile_pages/home-page.dart';
import 'package:Aanya/widgets/ellipse.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:Aanya/modules/image_desc_api.dart';
import 'package:Aanya/modules/text_to_speech.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Aanya/common_vars.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MobileImageDescription extends StatefulWidget {
  @override
  State<MobileImageDescription> createState() => _MobileImageDescriptionState();
}

class _MobileImageDescriptionState extends State<MobileImageDescription> {
  bool _imageSelected = false;
  String _description = 'Select an image to describe';
  File? _selectedImage;
  SpeechToText speechToText = SpeechToText();

  @override
  void initState() {
    super.initState();
    initTTS();
    speechToText.initialize();
  }

// For Listening after uploading image
  Future<String> startListening() async {
    Completer<String> completer = Completer<String>();
    await speechToText.listen(
      listenFor: Duration(milliseconds: 10000),
      pauseFor: Duration(milliseconds: 10000),
      onResult: (result) {
        if (result.finalResult) {
          completer.complete(result.recognizedWords);
        }
      },
    );
    return completer.future;
  }

// Converts user Image input to its Description
  void _getImageAndSendDescription() async {
    flutterTts.stop();
    // Show a dialog to let the user choose between camera and gallery
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    // child: ElevatedButton(
                    child: TextButton.icon(
                      icon: Icon(Icons.photo_library),
                      label: Text("Gallery"),
                      onPressed: () {
                        Navigator.pop(context, ImageSource.gallery);
                      },
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Expanded(
                    // child: ElevatedButton(
                    child: TextButton.icon(
                      icon: Icon(Icons.camera_alt),
                      label: Text("Camera"),
                      onPressed: () {
                        Navigator.pop(context, ImageSource.camera);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((dynamic result) async {
      if (result != null) {
        ImageSource source = result as ImageSource;
        final imagePicker = ImagePicker();
        final pickedImage = await imagePicker.pickImage(source: source);
        String description = "";

        if (pickedImage != null) {
          setState(() {
            _selectedImage = File(pickedImage.path);
            _imageSelected = true;
            _description = 'Processing...';
          });
          await Future.delayed(Duration(seconds: 2));
          await flutterTts.speak("Ok what do you want to know about it?");
          await Future.delayed(Duration(seconds: 3));

          // Send image to the API and get description
          if (_selectedImage != null) {
            String userprompt = await startListening();
            description = await imageDescAPI(_selectedImage!, userprompt);
          } else {
            print('No image provided');
          }

          setState(() {
            _description = description;
          });
        }
        flutterTts.speak(_description);
        try {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        } catch (e) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    reciver_context = context;
    final commonVars = Provider.of<CommonVariables>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) async {
        commonVars.updatePageName('home-scene');
      },
      child: Expanded(
        child: Container(
          child: Stack(
            children: [
              // Whole Page
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // header section - status,aanya,stars
                    Container(
                      margin: EdgeInsets.only(top: 20 * fem),
                      child: Column(
                        children: [
                          // Status
                          Container(
                            margin: EdgeInsets.only(top: 30 * fem),
                            width: 100 * ffem,
                            height: 30 * ffem,
                            decoration: ShapeDecoration(
                              color: Color(0x56494C89),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFF8EBBFF)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Align(
                              child: Text(
                                commonVars.aanyaStatus,
                                style: TextStyle(
                                  color: Color(0xFF8EBBFF),
                                  fontSize: 12 * ffem,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          // Aanya Model
                          Container(
                            width: 300 * fem,
                            height: 350 * fem,
                            child: ClipRRect(
                              child: Image.asset(
                                "assets/images/aanya-temp.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // body section - // Image View with stars
                    Container(
                      height: 250 * fem,
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 500),
                            left: _imageSelected ? 280 * fem : 220 * fem,
                            top: _imageSelected ? 0 * fem : 50 * fem,
                            child: SizedBox(
                              width: 70 * fem,
                              height: 80 * fem,
                              child: Image.asset(
                                'assets/images/animated-favicon-2.gif',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 500),
                            left: _imageSelected ? 20 * fem : 80 * fem,
                            top: _imageSelected ? 180 * fem : 120 * fem,
                            child: SizedBox(
                              width: 50 * fem,
                              height: 60 * fem,
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
                                      _getImageAndSendDescription();
                                      commonVars
                                          .updateAanyaStatus("Processing");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10 * fem,
                                        horizontal: 15 * fem,
                                      ),
                                      backgroundColor:
                                          Color.fromARGB(110, 164, 167, 255),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10 * fem))),
                                    ),
                                    child: Text(
                                      "Choose Image",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12 * fem),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: _imageSelected ? true : false,
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: (() {
                                        _getImageAndSendDescription();
                                        commonVars
                                            .updateAanyaStatus("Processing");
                                      }),
                                      child: Container(
                                        width: 250 * fem,
                                        height: 150 * fem,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30 * fem)),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30 * fem)),
                                          child: _selectedImage != null &&
                                                  File(_selectedImage!.path)
                                                      .existsSync()
                                              ? Image.file(
                                                  _selectedImage!,
                                                  fit: BoxFit.contain,
                                                )
                                              : Image.network(
                                                  "https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg",
                                                  fit: BoxFit.cover,
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
                      margin: EdgeInsets.only(bottom: 50 * fem, top: 5 * fem),
                      height: 100 * fem,
                      constraints: BoxConstraints(maxWidth: 300 * fem),
                      child: SingleChildScrollView(
                        child: Text(
                          _description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16 * fem,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Ellipse(
                left: 250 * fem,
                top: 237 * fem,
                width: 195 * fem,
                height: 199 * fem,
                innerColor: Color.fromARGB(143, 142, 95, 243),
                outerColor: Color.fromARGB(0, 142, 95, 243),
              ),
              Ellipse(
                left: -80 * fem,
                top: 20 * fem,
                width: 195 * fem,
                height: 199 * fem,
                innerColor: Color.fromARGB(143, 97, 95, 243),
                outerColor: Color.fromARGB(0, 83, 82, 159)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
