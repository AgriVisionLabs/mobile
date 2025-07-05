import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/diseaseDetections.dart';

List<DiseaseDetectionModel>? getList(
    List<DiseaseDetectionModel> info, int? status) {
  if (status != null) {
    return info.where((item) => item.healthStatus == status).toList();
  } else {
    return info;
  }
}

Color? getHealthLevelColor( int healthLevel) {
  if (healthLevel == 1) {
    return orange;
  } else if (healthLevel == 0) {
    return green;
  }else{
    return red;
  }
}


String? getHealthLevelLabel( int healthLevel) {
  if (healthLevel == 0) {
    return "Healthy";
  } else if (healthLevel == 1) {
    return "AtRisk";
  }else{
    return "Infected";
  }
}
