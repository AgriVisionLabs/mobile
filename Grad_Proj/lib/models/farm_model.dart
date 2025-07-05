import 'dart:ffi';

import 'package:grd_proj/service/api/end_points.dart';

class FarmModel {
   String ? farmId;
   String ? name;
   double ? area;
   String ? location;
   int ? soilType;
   int ? fieldsNo;
   String ? roleName;
   String ? ownerId;
   bool ? isOwner;

  FarmModel({this.farmId, this.name, this.area, this.location, this.soilType, this.fieldsNo, this.roleName, this.ownerId, this.isOwner});

  factory FarmModel.fromJson(Map<String,dynamic> jsonData){
    return FarmModel(
      farmId: jsonData[ApiKey.farmId],
      name: jsonData[ApiKey.name],
      area: jsonData[ApiKey.area],
      location: jsonData[ApiKey.location],
      soilType: jsonData[ApiKey.soilType],
      fieldsNo: jsonData[ApiKey.fieldsNo],
      roleName: jsonData[ApiKey.roleName],
      ownerId: jsonData[ApiKey.ownerId],
      isOwner: jsonData[ApiKey.isOwner]
    );
  }

}