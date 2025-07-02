import 'package:grd_proj/service/api/end_points.dart';

class FieldModel {
  final String id;
  final String name;
  final int area;
  final bool isActive;
  final String farmId;
  final int? cropType;
  final String? cropName;
  final String? description;
  final bool? supportsDiseaseDetection;
  final DateTime? plantingDate;
  final DateTime? expectedHarvestDate;
  final int? progress;

  FieldModel({
    required this.id,
    required this.name,
    required this.area,
    required this.isActive,
    required this.farmId,
     this.cropType,
     this.cropName,
     this.description,
     this.supportsDiseaseDetection,
     this.plantingDate,
     this.expectedHarvestDate,
     this.progress,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      id: json[ApiKey.id],
      name: json[ApiKey.name],
      area: json[ApiKey.area],
      isActive: json['isActive'],
      farmId: json[ApiKey.farmId],
      cropType: json[ApiKey.crop],
      cropName: json['cropName'],
      description: json['description'],
      supportsDiseaseDetection: json['supportsDiseaseDetection'],
      plantingDate: json['plantingDate'] == null ? null :DateTime.parse(json['plantingDate']),
      expectedHarvestDate: json['expectedHarvestDate'] == null ? null :DateTime.parse(json['expectedHarvestDate']),
      progress: json['progress'],
    );
  }

}
