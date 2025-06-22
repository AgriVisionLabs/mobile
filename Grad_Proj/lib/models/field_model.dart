class FieldModel {
  final String id;
  final String name;
  final int area;
  final bool isActive;
  final String farmId;
  final int crop;

  FieldModel({
    required this.id,
    required this.name,
    required this.area,
    required this.isActive,
    required this.farmId,
    required this.crop,
  });

  // Factory to create object from JSON
  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      id: json['id'],
      name: json['name'],
      area: json['area'],
      isActive: json['isActive'],
      farmId: json['farmId'],
      crop: json['crop'],
    );
  }

}
