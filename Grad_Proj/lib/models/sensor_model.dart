class SensorDevices {
  final String id;
  final String farmId;
  final String fieldId;
  final String fieldName;
  final String name;
  final bool isOnline;
  final String installationDate;
  final int status;
  final String? lastMaintenance;
  final String? nextMaintenance;
  final String? ipAddress;
  final String macAddress;
  final String serialNumber;
  final String firmWareVersion;
  final String addedById;
  final String addedBy;
  final String lastUpdated;
  final double? moisture;
  final double? temperature;
  final int? humidity;
  final int? batteryLevel;

  SensorDevices({
    required this.id,
    required this.farmId,
    required this.fieldId,
    required this.fieldName,
    required this.name,
    required this.isOnline,
    required this.installationDate,
    required this.status,
    this.lastMaintenance,
    this.nextMaintenance,
    this.ipAddress,
    required this.macAddress,
    required this.serialNumber,
    required this.firmWareVersion,
    required this.addedById,
    required this.addedBy,
    required this.lastUpdated,
    this.moisture,
    this.temperature,
    this.humidity,
    this.batteryLevel,
  });

  factory SensorDevices.fromJson(Map<String, dynamic> json) {
    return SensorDevices(
      id: json['id'],
      farmId: json['farmId'],
      fieldId: json['fieldId'],
      fieldName: json['fieldName'],
      name: json['name'],
      isOnline: json['isOnline'],
      installationDate: json['installationDate'],
      status: json['status'],
      lastMaintenance: json['lastMaintenance'],
      nextMaintenance: json['nextMaintenance'],
      ipAddress: json['ipAddress'],
      macAddress: json['macAddress'],
      serialNumber: json['serialNumber'],
      firmWareVersion: json['firmWareVersion'],
      addedById: json['addedById'],
      addedBy: json['addedBy'],
      lastUpdated: json['lastUpdated'],
      moisture: (json['moisture'] as num?)?.toDouble(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      humidity: json['humidity'],
      batteryLevel: json['batteryLevel'],
    );
  }

}
