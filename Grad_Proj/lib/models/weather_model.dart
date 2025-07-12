class DailyWeather {
  final List<String> dates;
  final List<double> maxTemps;
  final List<double> minTemps;
  final List<double> precipitation;
  final List<int> weatherCode;

  DailyWeather({
    required this.dates,
    required this.maxTemps,
    required this.minTemps,
    required this.precipitation,
    required this.weatherCode,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dates: List<String>.from(json['daily']['time']),
      maxTemps: List<double>.from(json['daily']['temperature_2m_max']),
      minTemps: List<double>.from(json['daily']['temperature_2m_min']),
      precipitation: List<double>.from(json['daily']['precipitation_sum']),
      weatherCode: List<int>.from(json['daily']['weathercode']),
    );
  }
}
