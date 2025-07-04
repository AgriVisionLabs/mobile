import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/field_model.dart';

Map category = {"Fertilizer": 0, "Chemicals": 1, "Treatments": 2, "Produce": 3};

String? getCategoryName(int cat) {
  return category.entries
      .firstWhere(
        (entry) => entry.value == cat,
        orElse: () => const MapEntry('Unknown', null),
      )
      .key;
}

String? getFieldName(List<FieldModel>? fields, String fieldId) {
  if (fields == null || fields == []) {
    return "Not Assigned";
  } else {
    fields.where((item) => item.id == fieldId).toString();
  }
  return null;
}

Color? getLevelColor( String level) {
  if (level == "High") {
    return green;
  } else if (level == "Medium") {
    return orange;
  }else{
    return red;
  }
}

Color? getColor( int? time) {
  if (time == null) {
    return orange;
  } else if (time > 0) {
    return green;
  }else{
    return red;
  }
}