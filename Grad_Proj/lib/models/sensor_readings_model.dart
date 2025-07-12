class SensorReadingModel {
  final String temperature;
  final String moisture;
  final String humidity;

  SensorReadingModel({
    required this.temperature,
    required this.moisture,
    required this.humidity,
  });

  factory SensorReadingModel.fromJson(Map<String, dynamic> json) {
    return SensorReadingModel(
      temperature: json['temperature'],
      moisture: json['moisture'].toString(),
      humidity: json['humidity'].toString(),
    );
  }
}
