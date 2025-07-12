import 'package:bloc/bloc.dart';
import 'package:grd_proj/models/location_model.dart';
import 'package:grd_proj/models/weather_hourly_model.dart';
import 'package:grd_proj/models/weather_model.dart';
import 'package:grd_proj/service/api/api_consumer.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/service/errors/exception.dart';
import 'package:intl/intl.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiConsumer api;
  WeatherBloc(this.api) : super(WeatherInitial()) {
    on<GetLocationName>((event, emit) async {
      emit(LocationInitial());
      try {
        final response = await api.get(
          EndPoints.locationUrl,
          queryParameters: {
            'name': event.locationName,
            'count': 1,
          },
        );
        final location = GeoLocationModel.fromJson(response["results"][0]);

        emit(LocationSuccess(locationModel: location));
      } on ServerException catch (e) {
        emit(LocationFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<GetLocationWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final response = await api.get(
          EndPoints.weatherUrl,
          queryParameters: {
            'latitude': event.latitude,
            'longitude': event.longitude,
            'daily':
                'temperature_2m_max,temperature_2m_min,precipitation_sum,weathercode,',
            'timezone': 'auto',
          },
        );
        final dailyWeather = DailyWeather.fromJson(response);
        emit(WeatherSuccess(weatherModel: dailyWeather));
      } on ServerException catch (e) {
        emit(WeatherFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<GetLocationWeatherToday>((event, emit) async {
      emit(WeatherTodayLoading());
      try {
        DateTime today = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(today);
        final response = await api.get(
          EndPoints.weatherUrl,
          queryParameters: {
            'latitude': 30.0626,
            'longitude': 31.2497,
            'hourly': 'relativehumidity_2m,temperature_2m',
            'start_date': formattedDate,
            'end_date': formattedDate,
            'timezone': 'auto',
          },
        );
        final dailyWeather = HourlyWeather.fromJson(response);
        emit(WeatherTodaySuccess(weatherModel: dailyWeather));
      } on ServerException catch (e) {
        emit(WeatherTodayFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
  }
}
