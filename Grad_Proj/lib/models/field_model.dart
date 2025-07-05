import 'package:grd_proj/service/api/end_points.dart';

class FieldModel {
  final String id;
  final String name;
  final double area;
  final bool isActive;
  final String farmId;
  final int? cropType;
  final String? cropName;
  final String? description;
  final bool? supportsDiseaseDetection;
  final DateTime? plantingDate;
  final DateTime? expectedHarvestDate;
  final double? progress;

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
      area: (json['area'] as num).toDouble(),
      isActive: json[ApiKey.isActive],
      farmId: json[ApiKey.farmId],
      cropType: json[ApiKey.cropType],
      cropName: json[ApiKey.cropName],
      description: json[ApiKey.description],
      supportsDiseaseDetection: json[ApiKey.supportsDiseaseDetection],
      plantingDate: json[ApiKey.plantingDate] == null ? null :DateTime.parse(json[ApiKey.plantingDate]),
      expectedHarvestDate: json[ApiKey.expectedHarvestDate] == null ? null :DateTime.parse(json[ApiKey.expectedHarvestDate]),
      progress: json[ApiKey.progress] == null ? null :(json[ApiKey.progress]as num).toDouble() ,
    );
  }

}
