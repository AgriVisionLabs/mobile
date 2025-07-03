import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

Widget text({Color? color, required double fontSize, FontWeight? fontWeight, required String label}) {
  return Text(label,
      style:  TextStyle(
        fontFamily: 'Manrope',
        color: color?? testColor,
        fontSize: fontSize,
        fontWeight: fontWeight?? FontWeight.w500,
      ));
}
