import 'package:grd_proj/core/api/end_points.dart';

class FarmModel {
  final String farmId;
  final String name;
  final int area;
  final String location;
  final int soilType;
  final int fieldsNo;
  final String roleName;
  final String ownerId;
  final bool isOwner;

  FarmModel({required this.farmId,required this.name,required this.area,required this.location,required this.soilType,required this.fieldsNo,required this.roleName,required this.ownerId,required this.isOwner});

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