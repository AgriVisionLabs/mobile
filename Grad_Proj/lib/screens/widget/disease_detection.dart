import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/diseaseDetections.dart';
import 'package:grd_proj/models/field_model.dart';

// bool? getList(
//     List<DiseaseDetectionModel> info, int? status) {
//   if (status != null) {
//     if(status==0){
//       return info.where((item) => item.isHealthy == true).toList();
//     }else{
//       return info.where((item) => item.isHealthy == false).toList();
//     }
//   } else {
//     return info;
//   }
// }

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
