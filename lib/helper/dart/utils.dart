import 'package:commitment_tracker/models/commitments.dart';
import 'package:flutter/material.dart';

const commitmentBox = 'commitments';

extension IntExtension on int {
  Color get toColor => this != null ? Color(this) : null;
}

extension StringExtension on String {
  bool get isNotNullOrEmpty => this != null && this.isNotEmpty;
}

extension ColorExtension on Color {
  Color get textColorForBackground =>
      ThemeData.estimateBrightnessForColor(this ?? Colors.white) == Brightness.dark
          ? Colors.white
          : Colors.black;
}

class Utils {
  static getTotal(List<Commitment> commitments) => commitments != null && commitments.isNotEmpty
      ? commitments.map((e) => e.value).reduce((value, element) => value + element).toString()
      : 0.0.toString();
}
