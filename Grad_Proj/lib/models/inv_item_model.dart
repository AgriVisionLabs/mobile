class InvItemModel {
  final String id;
  final String farmId;
  final String? fieldId;
  final String createdById;
  final String name;
  final int category;
  final int quantity;
  final int thresholdQuantity;
  final int unitCost;
  final String measurementUnit;
  final String? expirationDate;
  final int? dayTillExpiry;
  final String stockLevel;

  InvItemModel({
    required this.id,
    required this.farmId,
    this.fieldId,
    required this.createdById,
    required this.name,
    required this.category,
    required this.quantity,
    required this.thresholdQuantity,
    required this.unitCost,
    required this.measurementUnit,
    this.expirationDate,
    this.dayTillExpiry,
    required this.stockLevel,
  });

  factory InvItemModel.fromJson(Map<String, dynamic> json) {
    return InvItemModel(
      id: json['id'],
      farmId: json['farmId'],
      fieldId: json['fieldId'],
      createdById: json['createdById'],
      name: json['name'],
      category: json['category'],
      quantity: json['quantity'],
      thresholdQuantity: json['thresholdQuantity'],
      unitCost: json['unitCost'],
      measurementUnit: json['measurementUnit'],
      expirationDate: json['expirationDate'],
      dayTillExpiry: json['dayTillExpiry'],
      stockLevel: json['stockLevel'],
    );
  }

}
