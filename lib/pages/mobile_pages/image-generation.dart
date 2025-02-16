import 'package:Aanya/common_vars.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:Aanya/widgets/enlargeable_image.dart';
import 'package:Aanya/widgets/ellipse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileImageGeneration extends StatefulWidget {
  @override
  State<MobileImageGeneration> createState() => _MobileImageGenerationState();
}

class _MobileImageGenerationState extends State<MobileImageGeneration> {
  @override
  Widget build(BuildContext context) {
    final commonVars = Provider.of<CommonVariables>(context);
    reciver_context = context;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        commonVars.updatePageName('home-scene');
      },
      child: Expanded(
        child: Container(
          child: Stack(
            children: [
              // Whole Page
              Container(
                width: screen_width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // header section - status,aanya,stars
                    Container(
                      margin: EdgeInsets.only(top: 20 * fem),
                      child: Stack(
                        children: [
                          Positioned(
                            // nounstar55525263MvL (141:37)
                            left: 200 * fem,
                            top: 0 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 80 * fem,
                                height: 90 * fem,
                                child: Image.asset(
                                  'assets/images/animated-favicon-2.gif',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // nounstar55525263MvL (141:37)
                            left: 0 * fem,
                            top: 200 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 60 * fem,
                                height: 70 * fem,
                                child: Image.asset(
                                  'assets/images/animated-favicon-2.gif',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              // Status
                              Container(
                                width: 100 * ffem,
                                height: 30 * ffem,
                                decoration: ShapeDecoration(
                                  color: Color(0x54494C89),
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
                          )
                        ],
                      ),
                    ),
                    // body section - generated images
                    Visibility(
                      visible: commonVars.showImagesSection,
                      child: Container(
                        width: screen_width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                EnlargeableImage(
                                  image: commonVars.generatedImage != null
                                      ? FileImage(
                                          commonVars.generatedImage!,
                                        )
                                      : AssetImage(
                                          'assets/images/image-loader.gif',
                                        ) as ImageProvider,
                                ),
                                EnlargeableImage(
                                  image: commonVars.generatedImage != null
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                EnlargeableImage(
                                  image: commonVars.generatedImage != null
                                      ? FileImage(
                                          commonVars.generatedImage!,
                                        )
                                      : AssetImage(
                                          'assets/images/image-loader.gif',
                                        ) as ImageProvider,
                                ),
                                EnlargeableImage(
                                  image: commonVars.generatedImage != null
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
                        ),
                      ),
                    ),
                    // footer section - prompt
                    Container(
                      margin: EdgeInsets.only(bottom: 50 * fem, top: 20 * fem),
                      constraints: BoxConstraints(maxWidth: 300 * fem),
                      child: Text(
                        commonVars.generatedImage != null
                            ? "Generated Images you Requested"
                            : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16 * fem,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Ellipse(
                left: 199 * fem,
                top: 237 * fem,
                width: 195 * fem,
                height: 199 * fem,
                innerColor: Color.fromARGB(143, 97, 95, 243),
                outerColor: Color.fromARGB(0, 83, 82, 159),
              ),
              Ellipse(
                left: -82 * fem,
                top: -35 * fem,
                width: 195 * fem,
                height: 199 * fem,
                innerColor: Color.fromARGB(143, 97, 95, 243),
                outerColor: Color.fromARGB(0, 83, 82, 159),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
