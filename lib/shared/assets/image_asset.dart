import 'package:flutter/material.dart';

class ImageAsset {
  static Image squareLogo({
    double width = 50.0,
    double height = 50.0,
  }) =>
      Image.asset(
        'assets/images/blue_square.png',
        width: width,
        height: height,
      );

  static Image shortLogo({
    double width = 50.0,
    double height = 50.0,
  }) =>
      Image.asset(
        'assets/images/blue_short.png',
        width: width,
        height: height,
      );
}
