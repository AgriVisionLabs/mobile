part of 'weather_bloc.dart';

abstract class WeatherEvent{}




final class GetLocationName extends WeatherEvent {
  final String locationName;
  GetLocationName({required this.locationName});
}

final class GetLocationWeather extends WeatherEvent {
  final double latitude;
  final double longitude;
  GetLocationWeather({required this.latitude, required this.longitude});
}

final class GetLocationWeatherToday extends WeatherEvent {
  final double latitude;
  final double longitude;
  GetLocationWeatherToday({required this.latitude, required this.longitude});
}