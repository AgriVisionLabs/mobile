import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

Widget buildTag(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      // ignore: deprecated_member_use
      color: Colors.white,
      border: Border.all(color: borderColor, width: 2),
      borderRadius: BorderRadius.circular(25),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Manrope',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
