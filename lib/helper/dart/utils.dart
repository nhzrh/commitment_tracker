import 'package:flutter/material.dart';

class Utils {
  static Color textColorForBackground(Color backgroundColor) {
    if (ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark) {
      return Colors.white;
    }

    return Colors.black;
  }
}
