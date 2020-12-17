import 'package:e_commerce_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final height = constraints.maxHeight;
      final width = constraints.maxWidth;
      return Stack(children: [
        Container(color: bgColor),
        Positioned(
          left: -(height / 2 - width / 2),
          bottom: height * 0.16,
          child: Container(
            height: height,
            width: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: firstCircleColor,
            ),
          ),
        ),
        Positioned(
          left: width * 0.15,
          top: -width * 0.5,
          child: Container(
            height: width * 1.6,
            width: width * 1.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: secondCircleColor,
            ),
          ),
        ),
        Positioned(
          right: -width * 0.25,
          top: -50,
          child: Container(
            height: width * 0.8,
            width: width * 0.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: thirdCircleColor,
            ),
          ),
        ),
      ]);
    });
  }
}
