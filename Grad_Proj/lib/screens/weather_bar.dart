import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/weather/bloc/weather_bloc.dart';
import 'package:grd_proj/models/weather_model.dart';
import 'package:grd_proj/screens/widget/circule_indector.dart';
import 'package:grd_proj/screens/widget/weather.dart';

class WeatherBar extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const WeatherBar(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<WeatherBar> createState() => _WeatherBarState();
}


class _WeatherBarState extends State<WeatherBar> {
  DailyWeather? weather;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Weather Forcast',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: "Manrope")),
        const SizedBox(height: 48),
        BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherSuccess) {
              weather = state.weatherModel;
            }
          },
          builder: (context, state) {
            if (weather  == null) {
              return circularProgressIndicator();
            }
           else if ( weather != null) {
              return Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        weatherItem(
                            day: getDayName(weather!.dates[0]),
                            image: getImage(weather!.precipitation[0]),
                            temp: "${weather!.maxTemps[0]}°C",
                            screenWidth: widget.screenWidth),
                        weatherItem(
                            day: getDayName(weather!.dates[1]),
                            image: getImage(weather!.precipitation[1]),
                            temp: "${weather!.maxTemps[1]}°C",
                            screenWidth: widget.screenWidth),
                        weatherItem(
                            day: getDayName(weather!.dates[2]),
                            image: getImage(weather!.precipitation[2]),
                            temp: "${weather!.maxTemps[2]}°C",
                            screenWidth: widget.screenWidth)
                      ]),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        weatherItem(
                            day: getDayName(weather!.dates[3]),
                            image: getImage(weather!.precipitation[3]),
                            temp: "${weather!.maxTemps[3]}°C",
                            screenWidth: widget.screenWidth),
                        weatherItem(
                            day: getDayName(weather!.dates[4]),
                            image: getImage(weather!.precipitation[4]),
                            temp: "${weather!.maxTemps[4]}°C",
                            screenWidth: widget.screenWidth),
                        weatherItem(
                            day: getDayName(weather!.dates[5]),
                            image: getImage(weather!.precipitation[5]),
                            temp: "${weather!.maxTemps[5]}°C",
                            screenWidth: widget.screenWidth)
                      ])
                ],
              );
            }
            return circularProgressIndicator();
          },
        ),
      ],
    );
  }

}

Widget weatherItem(
    {required String day,
    required String image,
    required String temp,
    required double screenWidth}) {
  return Column(children: [
    Text(day, style: const TextStyle(fontSize: 16, color: Colors.black)),
    Image.asset(
      image,
      height: 32,
      width: 32,
    ),
    Text(temp, style: const TextStyle(fontSize: 16, color: Colors.black))
  ]);
}
  
