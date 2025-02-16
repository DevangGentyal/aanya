import 'package:Aanya/common_vars.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/widgets/enlargeable_image.dart';
import 'package:Aanya/widgets/ellipse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopImageGen extends StatefulWidget {
  @override
  State<DesktopImageGen> createState() => _DesktopImageGenState();
}

class _DesktopImageGenState extends State<DesktopImageGen> {
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
                            left: 0 * width_fem,
                            right: 30 * width_fem),
                        width: 800 * width_fem,
                        height: 600 * width_fem,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0 * width_fem,
                              top: 400 * height_fem,
                              child: SizedBox(
                                width: 100 * width_fem,
                                height: 130 * height_fem,
                                child: Image.asset(
                                  'assets/images/animated-favicon-2.gif',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 650 * width_fem,
                              top: 30 * height_fem,
                              child: SizedBox(
                                width: 100 * width_fem,
                                height: 80 * height_fem,
                                child: Image.asset(
                                  'assets/images/animated-favicon-2.gif',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            //Generated Images
                            Visibility(
                              visible: commonVars.showImagesSection,
                              child: Center(
                                child: Container(
                                  width: 600 * width_fem,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          EnlargeableImage(
                                            image: commonVars.generatedImage !=
                                                    null
                                                ? FileImage(
                                                    commonVars.generatedImage!,
                                                  )
                                                : AssetImage(
                                                    'assets/images/image-loader.gif',
                                                  ) as ImageProvider,
                                          ),
                                          EnlargeableImage(
                                            image: commonVars.generatedImage !=
                                                    null
                                                ? FileImage(
                                                    commonVars.generatedImage!,
                                                  )
                                                : AssetImage(
                                                    'assets/images/image-loader.gif',
                                                  ) as ImageProvider,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          EnlargeableImage(
                                            image: commonVars.generatedImage !=
                                                    null
                                                ? FileImage(
                                                    commonVars.generatedImage!,
                                                  )
                                                : AssetImage(
                                                    'assets/images/image-loader.gif',
                                                  ) as ImageProvider,
                                          ),
                                          EnlargeableImage(
                                            image: commonVars.generatedImage !=
                                                    null
                                                ? FileImage(
                                                    commonVars.generatedImage!,
                                                  )
                                                : AssetImage(
                                                    'assets/images/image-loader.gif',
                                                  ) as ImageProvider,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text View
                      Container(
                        margin: EdgeInsets.only(
                            left: 20 * width_fem,
                            right: 20 * width_fem,
                            bottom: 20 * width_fem),
                        constraints: BoxConstraints(maxWidth: 500 * width_fem),
                        child: Text(
                          commonVars.generatedImage != null
                              ? "Generated Images you Requested"
                              : "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30 * width_fem,
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
