class DiseaseDetectionModel {
  final String id;
  final String farmId;
  final String fieldId;
  final String cropName;
  final String diseaseName;
  final bool isHealthy;
  final int healthStatus;
  final DateTime createdOn;
  final double confidenceLevel;
  final String imageUrl;
  final String createdBy;
  final List<String> treatments;

  DiseaseDetectionModel({
    required this.id,
    required this.farmId,
    required this.fieldId,
    required this.cropName,
    required this.diseaseName,
    required this.isHealthy,
    required this.healthStatus,
    required this.createdOn,
    required this.confidenceLevel,
    required this.imageUrl,
    required this.createdBy,
    required this.treatments,
  });

  factory DiseaseDetectionModel.fromJson(Map<String, dynamic> json) {
    return DiseaseDetectionModel(
      id: json['id'],
      farmId: json['farmId'],
      fieldId: json['fieldId'],
      cropName: json['cropName'],
      diseaseName: json['diseaseName'],
      isHealthy: json['isHealthy'],
      healthStatus: json['healthStatus'],
      createdOn: DateTime.parse(json['createdOn']),
      confidenceLevel: (json['confidenceLevel'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      createdBy: json['createdBy'],
      treatments: List<String>.from(json['treatments']),
    );
  }


}
