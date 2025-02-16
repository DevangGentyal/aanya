import 'package:Aanya/widgets/ellipse.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:Aanya/common_vars.dart';
import 'package:provider/provider.dart';

class MobileAppSettings extends StatefulWidget {
  @override
  State<MobileAppSettings> createState() => _MobileAppSettingsState();
}

class _MobileAppSettingsState extends State<MobileAppSettings> {
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
          height: screen_height - 50,
          child: Stack(
            children: [
              Ellipse(
                left: 250 * fem,
                top: 86 * fem,
                width: 195 * fem,
                height: 195 * fem,
                innerColor: Color.fromARGB(255, 113, 59, 218),
                outerColor: Color.fromARGB(0, 83, 82, 159),
              ),
              Ellipse(
                left: -87 * fem,
                top: 222 * fem,
                width: 195 * fem,
                height: 195 * fem,
                innerColor: Color.fromARGB(255, 113, 59, 218),
                outerColor: Color.fromARGB(0, 83, 82, 159),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 100 * fem,
                    left: 20 * fem,
                    right: 20 * fem,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Multi Mode",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16 * fem),
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
                                                ? const Color.fromARGB(
                                                    255, 255, 255, 255)
                                                : Colors.grey),
                                        Icon(Icons.close,
                                            color: isYesSelected
                                                ? Colors.grey
                                                : const Color.fromARGB(
                                                    255, 255, 255, 255)),
                                      ],
                                      color: Colors
                                          .black, // Color of unselected icons
                                      selectedColor: Colors
                                          .white, // Color of selected icon
                                      fillColor: Color.fromARGB(255, 85, 86,
                                          169), // Background color when selected
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 20 * fem),
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
