import 'package:flutter/material.dart';

class Ellipse extends StatelessWidget {
  final double left, top, width, height, radius, inner_stop, outer_stop;
  final Color innerColor, outerColor;

  const Ellipse({
    Key? key,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.innerColor,
    required this.outerColor,
    this.radius = 0.5,
    this.inner_stop = 0,
    this.outer_stop = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Align(
        child: SizedBox(
          width: width,
          height: height,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: RadialGradient(
                center: Alignment(0, -0),
                radius: radius,
                colors: <Color>[
                  innerColor,
                  outerColor,
                ],
                stops: <double>[inner_stop, outer_stop],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
