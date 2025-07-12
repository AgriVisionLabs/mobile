part of 'weather_bloc.dart';


abstract class WeatherState{}


final class WeatherInitial extends WeatherState {}

final class LocationInitial extends WeatherState {}

final class LocationSuccess extends WeatherState {
  final GeoLocationModel locationModel;

  LocationSuccess({required this.locationModel});
}

final class LocationLoading extends WeatherState {}

final class LocationFailure extends WeatherState {
  final String errMessage;
  final dynamic errors;
  
  LocationFailure({required this.errMessage,required this.errors});
}


final class WeatherSuccess extends WeatherState {
  final DailyWeather weatherModel;

  WeatherSuccess({required this.weatherModel});
}

final class  WeatherLoading extends WeatherState {}

final class  WeatherFailure extends WeatherState {
  final String errMessage;
  final dynamic errors;
  
   WeatherFailure({required this.errMessage,required this.errors});
}

final class WeatherTodaySuccess extends WeatherState {
  final HourlyWeather weatherModel;

  WeatherTodaySuccess({required this.weatherModel});
}

final class  WeatherTodayLoading extends WeatherState {}

final class  WeatherTodayFailure extends WeatherState {
  final String errMessage;
  final dynamic errors;
  
   WeatherTodayFailure({required this.errMessage,required this.errors});
}


