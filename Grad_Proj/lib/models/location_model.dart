class GeoLocationModel {
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final String timezone;

  GeoLocationModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.timezone,
  });

  factory GeoLocationModel.fromJson(Map<String, dynamic> json) {
    return GeoLocationModel(
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      country: json['country'],
      timezone: json['timezone'],
    );
  }


}
