import 'package:flutter/material.dart';

class  WeatherBar extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const WeatherBar({super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<WeatherBar> createState() => _WeatherBarState();
}

class _WeatherBarState extends State< WeatherBar> {

  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weather Forcast',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontFamily: "Manrope"
          )
        ),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            weatherItem(
          day: "Today", 
          image: 'assets/images/sunny.png', 
          temp: "40°C", 
          screenWidth: widget.screenWidth),
            weatherItem(
          day: "Monday", 
          image: 'assets/images/sunny.png', 
          temp: "34°C", 
          screenWidth: widget.screenWidth),
            weatherItem(
          day: "Monday", 
          image: 'assets/images/cloudy.png', 
          temp: "25°C", 
          screenWidth: widget.screenWidth)
          ]
        ),
        const SizedBox(height: 24,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            weatherItem(
          day: "Today", 
          image: 'assets/images/ruiny.png', 
          temp: "10°C", 
          screenWidth: widget.screenWidth),
            weatherItem(
          day: "Monday", 
          image: 'assets/images/ruiny.png', 
          temp: "4°C", 
          screenWidth: widget.screenWidth),
            weatherItem(
          day: "Monday", 
          image: 'assets/images/ruiny.png', 
          temp: "7°C", 
          screenWidth: widget.screenWidth)
          ]
        )
      ],
    );
  }

}


Widget weatherItem  ({
  required String day,
  required String image,
  required String temp,
  required double screenWidth
}){
  return Column(
    children: [
      Text(day, style: const TextStyle(fontSize: 16, color: Colors.black)),
      Image.asset(image , height: 32,width: 32,),
      Text(temp, style: const TextStyle(fontSize: 16, color: Colors.black))
    ]
  );
}
  
