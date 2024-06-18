import 'package:flutter/material.dart';

extension EDouble on double {
  String convertToScore() {
    final convertedValue = this * 10;
    return convertedValue.toStringAsFixed(0);
  }

  Color getScoreColor() {
    if (this >= 7.5) {
      return Colors.green;
    } else if (this >= 5) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
