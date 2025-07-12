import 'package:flutter/material.dart';

class NavigationHelper {
  static void goTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void goReplace(BuildContext context, String route) {
    Navigator.pushReplacementNamed(context, route);
  }
}

