import 'package:Aanya/widgets/ellipse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Aanya/common_vars.dart';

class MobileGettingStarted extends StatefulWidget {
  MobileGettingStartedState createState() => MobileGettingStartedState();
}

class MobileGettingStartedState extends State<MobileGettingStarted> {
  double opacityLevel = 0.0; // Initial Opcaity Level
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.367, -0.8),
            radius: 2.01,
            colors: <Color>[Color(0xff53529f), Color(0xff0f0b2a)],
            stops: <double>[0, 0.407],
          ),
        ),
        child: Stack(
          children: [
            
            Ellipse(
              left: -10 * fem,
              top: 397 * fem,
              width: 140 * fem,
              height: 145 * fem,
              innerColor: Color.fromARGB(255, 84, 82, 203),
              outerColor: Color.fromARGB(125, 15, 11, 42),
              radius: 2.01,
              outer_stop: 0.2,
            ),

//
            Positioned(
              // Favicon - outlined
              left: 30 * fem,
              top: 300 * fem,
              child: SizedBox(
                width: 200 * fem,
                height: 230 * fem,
                child: Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    'assets/images/favicon-outlined.png',
                  ),
                ),
              ),
            ),
//
            Positioned(
              //  Rectangle Above
              left: -50 * fem,
              top: -250 * fem,
              child: SizedBox(
                width: 485.71 * fem,
                height: 505.82 * fem,
                child: Image.asset(
                  'assets/images/rectangle-2.png',
                ),
              ),
            ),
//
            Positioned(
                left: 150 * fem,
                top: 50 * fem, // Slide up when opacity is 1.0
                child: Animate(
                  effects: [
                    FadeEffect(duration: Duration(milliseconds: 700)),
                    SlideEffect(
                        begin: Offset(0.0, 0.15),
                        end: Offset(0.0, 0.0),
                        duration: Duration(milliseconds: 500))
                  ],
                  child: SizedBox(
                    width: 220 * fem,
                    height: 450 * fem,
                    child: Image.asset(
                      'assets/images/aanya-temp.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
//
            Positioned(
              // Rectangle Below
              left: -60 * fem,
              top: 306.0021362305 * fem,
              child: SizedBox(
                width: 476.33 * fem,
                height: 507.5 * fem,
                child: Image.asset(
                  'assets/images/rectangle-1.png',
                ),
              ),
            ),
//
            Positioned(
              // FavIcon
              left: 31.984375 * fem,
              top: 438.9406280518 * fem,
              child: SizedBox(
                width: 47.23 * fem,
                height: 58.81 * fem,
                child: Image.asset(
                  'assets/images/favicon.png',
                ),
              ),
            ),
//
            Positioned(
              // meetaanyaTpG (7:12)
              left: 39 * fem,
              top: 521 * fem,
              child: SizedBox(
                width: 200 * fem,
                height: 56 * fem,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Meet ',
                        style: TextStyle(
                          fontSize: 30 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.2125 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                      TextSpan(
                        text: 'Aanya',
                        style: GoogleFonts.oleoScriptSwashCaps(
                          fontSize: 40 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.385 * ffem / fem,
                          color: Color(0xffff9ea1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
//
            Positioned(
              // yourownassistantKzt (8:14)
              left: 38 * fem,
              top: 565 * fem,
              child: SizedBox(
                width: 281 * fem,
                height: 37 * fem,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 30 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.2125 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                    children: [
                      const TextSpan(
                        text: 'Your ',
                      ),
                      TextSpan(
                        text: 'own',
                        style: TextStyle(
                          fontSize: 30 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.2125 * ffem / fem,
                          color: Color(0xffff9ea1),
                        ),
                      ),
                      const TextSpan(
                        text: ' Assistant',
                      ),
                    ],
                  ),
                ),
              ),
            ),
//
            Positioned(
              // letsuncoverthecapabilitesqrk (8:15)
              left: 44 * fem,
              top: 601 * fem,
              child: SizedBox(
                width: 165 * fem,
                height: 23 * fem,
                child: Text(
                  'lets uncover the capabilites',
                  style: GoogleFonts.oleoScriptSwashCaps(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.385 * ffem / fem,
                    color: Color(0xffca95eb),
                  ),
                ),
              ),
            ),
//
            Positioned(
              // getstartedbuttonKG8 (15:103)
              left: 38 * fem,
              top: 661 * fem,
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login_reg');
                    ;
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (Colors) => const Color.fromARGB(255, 255, 158, 162)),
                    padding: MaterialStateProperty.resolveWith((Padding) =>
                        EdgeInsets.symmetric(
                            vertical: 20 * fem, horizontal: 20 * fem)),
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Color.fromARGB(255, 235, 188, 185)
                              .withOpacity(0.8);
                        }
                        return Color.fromARGB(255, 138, 187, 255);
                      },
                    ),
                  ),
                  child: Row(children: [
                    Text(
                      "Getting Started",
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 16.0,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.purple[900],
                    ),
                  ]),
                ),
              ),
            ),
//
// End of Inner Elements of Stack
          ],
        ),
      ),
    );
  } //End of Build Method
} //Closing Getting Started Class
