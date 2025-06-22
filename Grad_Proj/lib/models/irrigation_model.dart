class IrrigationDevice {
  final String id;
  final String farmId;
  final String fieldId;
  final String fieldName;
  final String name;
  final bool isOnline;
  final bool isOn;
  final DateTime installationDate;
  final int status;
  final DateTime? lastMaintenance;
  final DateTime? nextMaintenance;
  final String? ipAddress;
  final String macAddress;
  final String serialNumber;
  final String firmWareVersion;
  final String addedById;
  final String addedBy;
  final String lastOperationDuration;
  final DateTime lastUpdated;

  IrrigationDevice({
    required this.id,
    required this.farmId,
    required this.fieldId,
    required this.fieldName,
    required this.name,
    required this.isOnline,
    required this.isOn,
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
    required this.lastOperationDuration,
    required this.lastUpdated,
  });

  factory IrrigationDevice.fromJson(Map<String, dynamic> json) {
    return IrrigationDevice(
      id: json['id'],
      farmId: json['farmId'],
      fieldId: json['fieldId'],
      fieldName: json['fieldName'],
      name: json['name'],
      isOnline: json['isOnline'],
      isOn: json['isOn'],
      installationDate: DateTime.parse(json['installationDate']),
      status: json['status'],
      lastMaintenance: json['lastMaintenance'] != null
          ? DateTime.tryParse(json['lastMaintenance'])
          : null,
      nextMaintenance: json['nextMaintenance'] != null
          ? DateTime.tryParse(json['nextMaintenance'])
          : null,
      ipAddress: json['ipAddress'],
      macAddress: json['macAddress'],
      serialNumber: json['serialNumber'],
      firmWareVersion: json['firmWareVersion'],
      addedById: json['addedById'],
      addedBy: json['addedBy'],
      lastOperationDuration: json['lastOperationDuration'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}
