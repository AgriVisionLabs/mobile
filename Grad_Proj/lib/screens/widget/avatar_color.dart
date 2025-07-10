import 'package:flutter/material.dart';

Color getColorFromLetter(String letter) {
  final normalized = letter.toUpperCase();
  final code = normalized.codeUnitAt(0); // A = 65, B = 66, ...
  final colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
    Colors.brown,
    Colors.cyan,
    Colors.pink,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightGreen,
  ];
  return colors[code % colors.length];
}
