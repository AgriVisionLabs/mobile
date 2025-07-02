class CropModel {
  final String id;
  final String name;
  final int cropType;
  final int soilType;
  final bool supportsDiseaseDetection;
  final bool recommended;

  CropModel({
    required this.id,
    required this.name,
    required this.cropType,
    required this.soilType,
    required this.supportsDiseaseDetection,
    required this.recommended,
  });

  factory CropModel.fromJson(Map<String, dynamic> json) {
    return CropModel(
      id: json['id'],
      name: json['name'],
      cropType: json['cropType'],
      soilType: json['soilType'],
      supportsDiseaseDetection: json['supportsDiseaseDetection'],
      recommended: json['recommended'],
    );
  }
}
