class AutomationRuleModel {
  final String id;
  final String farmId;
  final String fieldId;
  final String fieldName;
  final String name;
  final bool isEnabled;
  final int type;
  final String sensorId;
  final String irrigationUnitId;
  final double? minThresholdValue;
  final double? maxThresholdValue;
  final int? targetSensorType;
  final String? startTime;
  final String? endTime;
  final int? activeDays;

  AutomationRuleModel({
    required this.id,
    required this.farmId,
    required this.fieldId,
    required this.fieldName,
    required this.name,
    required this.isEnabled,
    required this.type,
    required this.sensorId,
    required this.irrigationUnitId,
    this.minThresholdValue,
    this.maxThresholdValue,
    this.targetSensorType,
    this.startTime,
    this.endTime,
    this.activeDays,
  });

  factory AutomationRuleModel.fromJson(Map<String, dynamic> json) {
    return AutomationRuleModel(
      id: json['id'],
      farmId: json['farmId'],
      fieldId: json['fieldId'],
      fieldName: json['fieldName'],
      name: json['name'],
      isEnabled: json['isEnabled'],
      type: json['type'],
      sensorId: json['sensorId'],
      irrigationUnitId: json['irrigationUnitId'],
      minThresholdValue: json['minThresholdValue']?.toDouble(),
      maxThresholdValue: json['maxThresholdValue']?.toDouble(),
      targetSensorType: json['targetSensorType'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      activeDays: json['activeDays'],
    );
  }

  
  
}
