
import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/diseaseDetections.dart';

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

Color? getHealthLevelColor(int healthLevel) {
  if (healthLevel == 1) {
    return orange;
  } else if (healthLevel == 0) {
    return green;
  } else {
    return red;
  }
}

String? getHealthLevelLabel(int healthLevel) {
  if (healthLevel == 0) {
    return "Healthy";
  } else if (healthLevel == 1) {
    return "AtRisk";
  } else {
    return "Infected";
  }
}

String? getHealthLabel(bool healthy) {
  if (healthy) {
    return "Healthy";
  } else{
    return "Infected";
  }
}

Color? getHealthColor(bool healthy) {
  if (healthy) {
    return green;
  } else{
    return red;
  }
}


double? getrisk(List<DiseaseDetectionModel> info) {
  final totalProgress = info.fold(0, (sum, info) => sum + (info.healthStatus));
  final risk = info.isNotEmpty ? ((100 - totalProgress) / info.length) : 0;
  return risk.toDouble();
}

int getlevl(double risk) {
  if (risk > 77) {
    return 0;
  } else if (risk > 44) {
    return 1;
  } else {
    return 2;
  }
}
