// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:grd_proj/screens/alerts_bar.dart';
import 'package:grd_proj/screens/todo_bar.dart';
import 'package:grd_proj/screens/activity_bar.dart';
import '../Components/color.dart';
import 'weather_bar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String? selectedValue;
  List<String> farms = ['Farm 1', 'Farm 2', 'Farm 3'];
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(top: 16),
          height: MediaQuery.sizeOf(context).height,
          child: ListView(scrollDirection: Axis.vertical, children: [
            Row(
              children: [
                SizedBox(width: 35),
                Container(
                  padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                  width: 289,
                  height: 53,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: borderColor, width: 1)),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                    value: selectedValue,
                    isExpanded: true,
                    icon: Image.asset(
                      'assets/images/arrow.png',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    items: farms.map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: 76,
                  height: 30,
                  margin: const EdgeInsets.only(left: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: borderColor, width: 1)),
                  child: Center(
                    child: Text(
                      "Owner",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    child: Container(
                        padding: const EdgeInsets.all(24),
                        width: 380,
                        height: 161,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Field 1',
                                      style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'manrope',
                                      )),
                                  Spacer(),
                                  Container(
                                    width: 73,
                                    height: 30,
                                    margin: const EdgeInsets.only(left: 25),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: borderColor, width: 1)),
                                    child: Center(
                                      child: Text(
                                        "active",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'manrope'),
                                      ),
                                    ),
                                  )
                                ]),
                            SizedBox(height: 18),
                            Text('Corn',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                )),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: 0.65,
                                backgroundColor: Colors.grey[300],
                                color: Colors.green[900],
                                minHeight: 6,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Progress: 65%",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ))),
                SizedBox(height: 24),
                Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    child: Container(
                        padding: const EdgeInsets.all(24),
                        width: 380,
                        height: 161,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Field 2',
                                      style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'manrope',
                                      )),
                                  Spacer(),
                                  Container(
                                    width: 73,
                                    height: 30,
                                    margin: const EdgeInsets.only(left: 25),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: borderColor, width: 1)),
                                    child: Center(
                                      child: Text(
                                        "active",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'manrope'),
                                      ),
                                    ),
                                  )
                                ]),
                            SizedBox(height: 18),
                            Text('Tomato',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                )),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: 0.4,
                                backgroundColor: Colors.grey[300],
                                color: Colors.green[900],
                                minHeight: 6,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Progress: 40%",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ))),
                SizedBox(height: 24),
                Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    child: Container(
                        padding: const EdgeInsets.all(24),
                        width: 380,
                        height: 161,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Field 3',
                                      style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'manrope',
                                      )),
                                  Spacer(),
                                  Container(
                                    width: 73,
                                    height: 30,
                                    margin: const EdgeInsets.only(left: 25),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: borderColor, width: 1)),
                                    child: Center(
                                      child: Text(
                                        "active",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'manrope'),
                                      ),
                                    ),
                                  )
                                ]),
                            SizedBox(height: 18),
                            Text('Botato',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                )),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: 0.86,
                                backgroundColor: Colors.grey[300],
                                color: Colors.green[900],
                                minHeight: 6,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Progress: 86%",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ))),
                SizedBox(height: 20),
                //Weather
                Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                        padding: const EdgeInsets.all(24),
                        width: 380,
                        height: 324,
                        child: WeatherBar(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight))),
                const SizedBox(height: 60),

                //Alerts
                Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                        padding: const EdgeInsets.all(24),
                        width: 380,
                        height: 266,
                        child: const AlertsBar())),
                SizedBox(height: 50),
                Text(
                  'Key Performance Indicators',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'manrope'),
                ),
                SizedBox(height: 20),
                Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    child: Container(
                        padding: const EdgeInsets.all(24),
                        width: 380,
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text('Temperature',
                                  style: TextStyle(
                                    color: Colors.green[900],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'manrope',
                                  )),
                              Spacer(),
                              Image.asset('assets/images/temp.png')
                            ]),
                            SizedBox(height: 30),
                            Text('Good',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                )),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: 0.55,
                                backgroundColor: Colors.grey[300],
                                color: Colors.green[900],
                                minHeight: 6,
                              ),
                            ),
                            SizedBox(height: 4),
                          ],
                        ))),
                SizedBox(height: 24),
                Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    child: Container(
                        padding: const EdgeInsets.all(24),
                        width: 380,
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text('Moisture level',
                                  style: TextStyle(
                                    color: Colors.green[900],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'manrope',
                                  )),
                              Spacer(),
                              Image.asset('assets/images/water.png')
                            ]),
                            SizedBox(height: 30),
                            Text('Optimal',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                )),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: 0.20,
                                backgroundColor: Colors.grey[300],
                                color: Colors.green[900],
                                minHeight: 6,
                              ),
                            ),
                            SizedBox(height: 4),
                          ],
                        ))),
                SizedBox(height: 24),
                Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    child: Container(
                        padding: const EdgeInsets.all(24),
                        width: 380,
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text('Crop growth',
                                  style: TextStyle(
                                    color: Colors.green[900],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'manrope',
                                  )),
                              Spacer(),
                              Image.asset('assets/images/growth.png')
                            ]),
                            SizedBox(height: 30),
                            Text('On Track',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                )),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: 0.35,
                                backgroundColor: Colors.grey[300],
                                color: Colors.green[900],
                                minHeight: 6,
                              ),
                            ),
                            SizedBox(height: 4),
                          ],
                        ))),
                SizedBox(height: 24),
                Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    child: Container(
                        padding: const EdgeInsets.all(24),
                        width: 380,
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text('Yield forecast',
                                  style: TextStyle(
                                    color: Colors.green[900],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'manrope',
                                  )),
                              Spacer(),
                              Image.asset('assets/images/forcast.png')
                            ]),
                            SizedBox(height: 30),
                            Text('4.2 tons/acre',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                )),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: 0.70,
                                backgroundColor: Colors.grey[300],
                                color: Colors.green[900],
                                minHeight: 6,
                              ),
                            ),
                            SizedBox(height: 4),
                          ],
                        ))),
                SizedBox(height: 50),
                //Recent Activity
                Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 22),
                        width: 380,
                        height: 396,
                        child: const Activitybar())),
                const SizedBox(height: 50),
                //To-Do List
                Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 22),
                        width: 380,
                        height: 396,
                        child: const TodoBar())),
                const SizedBox(height: 20),
              ],
            )
          ]),
        ));
  }
}
