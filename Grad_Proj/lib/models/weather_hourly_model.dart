class HourlyWeather {
  final List<DateTime> time;
  final List<int> relativeHumidity2m;
  final List<double> temperature2m;

  HourlyWeather({
    required this.time,
    required this.relativeHumidity2m,
    required this.temperature2m,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    List<DateTime> times = (json['hourly']['time'] as List)
        .map((e) => DateTime.parse(e))
        .toList();

    List<int> humidity = (json['hourly']['relativehumidity_2m'] as List)
        .map((e) => e as int)
        .toList();

    List<double> temperature = (json['hourly']['temperature_2m'] as List)
        .map((e) => (e as num).toDouble())
        .toList();

    return HourlyWeather(
      time: times,
      relativeHumidity2m: humidity,
      temperature2m: temperature,
    );
  }
}
