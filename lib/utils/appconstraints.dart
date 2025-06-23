import 'package:flutter/material.dart';

class AppConstraints {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static bool isMobile(BuildContext context) {
    return screenWidth(context) < 600;
  }
  static bool isTablet(BuildContext context) {
    return screenWidth(context) >= 600 && screenWidth(context) <=1200;
  }
}
