import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:Aanya/common_vars.dart';
import 'package:provider/provider.dart';

class DesktopAppSettings extends StatefulWidget {
  @override
  State<DesktopAppSettings> createState() => _DesktopAppSettingsState();
}

class _DesktopAppSettingsState extends State<DesktopAppSettings> {
  bool saved = false;
  bool isYesSelected = false;

  @override
  Widget build(BuildContext context) {
    final commonVars = Provider.of<CommonVariables>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        commonVars.updatePageName('settings');
      },
      child: Expanded(
        child: Container(
          height: screen_height - 100,
          child: Stack(
            children: [
              Positioned(
                // ellipse purple Top Right(15:24)
                left: 250 * fem,
                top: 86 * fem,
                child: Align(
                  child: SizedBox(
                    width: 195 * fem,
                    height: 195 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(203.5 * fem),
                        gradient: RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.4,
                          colors: <Color>[
                            Color.fromARGB(255, 113, 59, 218),
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
                // ellipse purple Middle(15:24)
                left: -87 * fem,
                top: 222 * fem,
                child: Align(
                  child: SizedBox(
                    width: 195 * fem,
                    height: 195 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(203.5 * fem),
                        gradient: RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.4,
                          colors: <Color>[
                            Color.fromARGB(255, 113, 59, 218),
                            Color.fromRGBO(113, 59, 218, 0)
                          ],
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 100 * fem,
                    left: 100 * fem,
                    right: 100 * fem,
                    bottom: 100 * fem),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      color: const Color.fromARGB(110, 158, 158, 158)
                          .withOpacity(0.1), // Adjust opacity as needed
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20 * fem),
                            child: Text(
                              'App Settings',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Body
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Multi Mode",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20 * fem),
                                    ),
                                    ToggleButtons(
                                      isSelected: [
                                        isYesSelected,
                                        !isYesSelected
                                      ],
                                      onPressed: (index) {
                                        setState(() {
                                          // Toggle the selection when pressed
                                          isYesSelected = index == 0;
                                        });
                                      },
                                      children: [
                                        Icon(Icons.check,
                                            color: isYesSelected
                                                ? const Color.fromARGB(255, 255, 255, 255)
                                                : Colors.grey),
                                        Icon(Icons.close,
                                            color: isYesSelected
                                                ? Colors.grey
                                                : const Color.fromARGB(255, 255, 255, 255)),
                                      ],
                                      borderColor: Colors.white,
                                      selectedBorderColor: Colors.white,
                                      color: Colors
                                          .black, // Color of unselected icons
                                      selectedColor: Colors
                                          .white, // Color of selected icon
                                      fillColor: Color.fromARGB(255, 85, 86, 169), // Background color when selected
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 100 * fem),
                              child: ElevatedButton(
                                onPressed: () async {},
                                child: Text(saved ? "Saved" : "Save Changes"),
                              ),
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
    );
  }
}
