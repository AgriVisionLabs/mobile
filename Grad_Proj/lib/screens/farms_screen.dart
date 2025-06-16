// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/screens/new_farm.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../Components/color.dart';
import 'edit_farm.dart';
import 'home_screen.dart';

class FarmsScreen extends StatefulWidget {
  final List farms; // Accept farms list
  const FarmsScreen({super.key, required this.farms});

  @override
  State<FarmsScreen> createState() => _FarmsScreen();
}

class _FarmsScreen extends State<FarmsScreen> {
  bool tell = false;
  void _onInputChanged(List farm) {
    setState(() {
      tell = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmBloc, FarmState>(
      builder: (context, state) {
        if (state is FarmInitial || state is FarmFailure) {
          return Scaffold(
            backgroundColor: Colors.white,
            body:_buildEmptyState(context),
          );
        }
        if (state is FarmLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            body:_buildFarmsList() 
          );
        }
        return CircularPercentIndicator(radius: 15);
      },
    );
  }

  Widget _buildFarmsList() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: MediaQuery.sizeOf(context).height,
      child: ListView(scrollDirection: Axis.vertical, children: [
        Row(
          children: [
            Container(
              child: Text("Farms Management",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    shadows: const [],
                    fontFamily: 'manrope',
                  )),
            ),
            Spacer(),
            SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color(0xFF1E6930)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewFarm(
                              onInputChanged: _onInputChanged,
                            )),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              initialIndex: 5,
                            )));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(50, 0, 0, 0),
                            blurRadius: 10,
                            spreadRadius: 0.7,
                            offset: Offset(0, 2.25))
                      ]),
                  child: Container(
                      padding: const EdgeInsets.all(24),
                      width: 380,
                      height: 425,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Green Fram',
                                  style: TextStyle(
                                    color: Color(0xff1E6930),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "manrope",
                                  )),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/location.png',
                                  ),
                                  SizedBox(width: 8),
                                  Text("SpringField, IL",
                                      style: TextStyle(
                                        color: Color(0xff616161),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "manrope",
                                      )),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Text("Fields : 1",
                                      style: TextStyle(
                                        color: Color(0xff0D121C),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "manrope",
                                      )),
                                  Spacer(),
                                  Text("Area : 500 acres",
                                      style: TextStyle(
                                        color: Color(0xff0D121C),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "manrope",
                                      )),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Text("Avg. Growth : 75%",
                                      style: TextStyle(
                                        color: Color(0xff0D121C),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "manrope",
                                      )),
                                  Spacer(),
                                  Text("Soil Type : Clay",
                                      style: TextStyle(
                                        color: Color(0xff0D121C),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "manrope",
                                      )),
                                ],
                              ),
                              SizedBox(height: 28),
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    color: Colors.white,
                                    child: CircularPercentIndicator(
                                      radius: 50.0, // Size of the circle
                                      lineWidth:
                                          9.0, // Thickness of the progress bar
                                      percent:
                                          0.30, // 30% progress (value between 0.0 and 1.0)
                                      center: Text(
                                        "30%",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          fontFamily: 'manrope',
                                        ),
                                      ),
                                      progressColor: Color(
                                          0xff1E6930), // Progress bar color
                                      backgroundColor: Color.fromARGB(
                                          255,
                                          202,
                                          227,
                                          206), // Background color of the progress
                                      circularStrokeCap: CircularStrokeCap
                                          .round, // Rounded edges for smooth look
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text('Corn',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "manrope",
                                      )),
                                ],
                              ),
                              SizedBox(height: 22),
                              Row(
                                children: [
                                  Container(
                                    width: 77,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: borderColor, width: 1)),
                                    child: Center(
                                      child: Text(
                                        "Worker",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      print("edit it");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditFarm(
                                                  farm: widget.farms)));
                                    },
                                    child: Image.asset('assets/images/edit.png',
                                        width: 30, height: 30),
                                  ),
                                  SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {
                                      print("delete it");
                                    },
                                    child: Image.asset(
                                        'assets/images/delete.png',
                                        width: 30,
                                        height: 30),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ))),
            ),
            SizedBox(height: 24),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(50, 0, 0, 0),
                          blurRadius: 10,
                          spreadRadius: 0.7,
                          offset: Offset(0, 2.25))
                    ]),
                child: Container(
                    padding: const EdgeInsets.all(24),
                    width: 380,
                    height: 255,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Green Fram',
                                style: TextStyle(
                                  color: Color(0xff1E6930),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "manrope",
                                )),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/location.png',
                                ),
                                SizedBox(width: 8),
                                Text("SpringField, IL",
                                    style: TextStyle(
                                      color: Color(0xff616161),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Text("Fields : 0",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                                Spacer(),
                                Text("Area : 500 acres",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Text("Soil Type : Clay",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 22),
                            Row(
                              children: [
                                Container(
                                  width: 77,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: borderColor, width: 1)),
                                  child: Center(
                                    child: Text(
                                      "Worker",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditFarm(farm: widget.farms)),
                                    );
                                  },
                                  child: Image.asset('assets/images/edit.png',
                                      width: 30, height: 30),
                                ),
                                SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    print("delete it");
                                  },
                                  child: Image.asset('assets/images/delete.png',
                                      width: 30, height: 30),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ))),
            SizedBox(height: 24),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(50, 0, 0, 0),
                          blurRadius: 10,
                          spreadRadius: 0.7,
                          offset: Offset(0, 2.25))
                    ]),
                child: Container(
                    padding: const EdgeInsets.all(24),
                    width: 380,
                    height: 425,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Green Fram',
                                style: TextStyle(
                                  color: Color(0xff1E6930),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "manrope",
                                )),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/location.png',
                                ),
                                SizedBox(width: 8),
                                Text("SpringField, IL",
                                    style: TextStyle(
                                      color: Color(0xff616161),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Text("Fields : 2",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                                Spacer(),
                                Text("Area : 500 acres",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Text("Avg. Growth : 75%",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                                Spacer(),
                                Text("Soil Type : Clay",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: CircularPercentIndicator(
                                        radius: 50.0, // Size of the circle
                                        lineWidth:
                                            9.0, // Thickness of the progress bar
                                        percent:
                                            0.78, // 30% progress (value between 0.0 and 1.0)
                                        center: Text(
                                          "78%",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            fontFamily: 'manrope',
                                          ),
                                        ),
                                        progressColor: Color(
                                            0xff1E6930), // Progress bar color
                                        backgroundColor: Color.fromARGB(
                                            255,
                                            202,
                                            227,
                                            206), // Background color of the progress
                                        circularStrokeCap: CircularStrokeCap
                                            .round, // Rounded edges for smooth look
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text('Tomato',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "manrope",
                                        )),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: CircularPercentIndicator(
                                        radius: 50.0, // Size of the circle
                                        lineWidth:
                                            9.0, // Thickness of the progress bar
                                        percent:
                                            0.63, // 30% progress (value between 0.0 and 1.0)
                                        center: Text(
                                          "63%",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            fontFamily: 'manrope',
                                          ),
                                        ),
                                        progressColor: Color(
                                            0xff1E6930), // Progress bar color
                                        backgroundColor: Color.fromARGB(
                                            255,
                                            202,
                                            227,
                                            206), // Background color of the progress
                                        circularStrokeCap: CircularStrokeCap
                                            .round, // Rounded edges for smooth look
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text('Botato',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "manrope",
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 22),
                            Row(
                              children: [
                                Container(
                                  width: 77,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: borderColor, width: 1)),
                                  child: Center(
                                    child: Text(
                                      "Worker",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    print("edit it");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditFarm(farm: widget.farms)));
                                  },
                                  child: Image.asset('assets/images/edit.png',
                                      width: 30, height: 30),
                                ),
                                SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    print("delete it");
                                  },
                                  child: Image.asset('assets/images/delete.png',
                                      width: 30, height: 30),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ))),
            SizedBox(height: 24),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(50, 0, 0, 0),
                          blurRadius: 10,
                          spreadRadius: 0.7,
                          offset: Offset(0, 2.25))
                    ]),
                child: Container(
                    padding: const EdgeInsets.all(24),
                    width: 380,
                    height: 615,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Green Fram',
                                style: TextStyle(
                                  color: Color(0xff1E6930),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "manrope",
                                )),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/location.png',
                                ),
                                SizedBox(width: 8),
                                Text("SpringField, IL",
                                    style: TextStyle(
                                      color: Color(0xff616161),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Text("Fields : 3",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                                Spacer(),
                                Text("Area : 500 acres",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Text("Avg. Growth : 75%",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                                Spacer(),
                                Text("Soil Type : Clay",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 28),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          child: CircularPercentIndicator(
                                            radius: 50.0, // Size of the circle
                                            lineWidth:
                                                9.0, // Thickness of the progress bar
                                            percent:
                                                0.78, // 30% progress (value between 0.0 and 1.0)
                                            center: Text(
                                              "78%",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                fontFamily: 'manrope',
                                              ),
                                            ),
                                            progressColor: Color(
                                                0xff1E6930), // Progress bar color
                                            backgroundColor: Color.fromARGB(
                                                255,
                                                202,
                                                227,
                                                206), // Background color of the progress
                                            circularStrokeCap: CircularStrokeCap
                                                .round, // Rounded edges for smooth look
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Text('Tomato',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "manrope",
                                            )),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          child: CircularPercentIndicator(
                                            radius: 50.0, // Size of the circle
                                            lineWidth:
                                                9.0, // Thickness of the progress bar
                                            percent:
                                                0.63, // 30% progress (value between 0.0 and 1.0)
                                            center: Text(
                                              "63%",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                fontFamily: 'manrope',
                                              ),
                                            ),
                                            progressColor: Color(
                                                0xff1E6930), // Progress bar color
                                            backgroundColor: Color.fromARGB(
                                                255,
                                                202,
                                                227,
                                                206), // Background color of the progress
                                            circularStrokeCap: CircularStrokeCap
                                                .round, // Rounded edges for smooth look
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Text('Botato',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "manrope",
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 48),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  color: Colors.white,
                                  child: CircularPercentIndicator(
                                    radius: 50.0, // Size of the circle
                                    lineWidth:
                                        9.0, // Thickness of the progress bar
                                    percent:
                                        0.18, // 30% progress (value between 0.0 and 1.0)
                                    center: Text(
                                      "18%",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        fontFamily: 'manrope',
                                      ),
                                    ),
                                    progressColor:
                                        Color(0xff1E6930), // Progress bar color
                                    backgroundColor: Color.fromARGB(
                                        255,
                                        202,
                                        227,
                                        206), // Background color of the progress
                                    circularStrokeCap: CircularStrokeCap
                                        .round, // Rounded edges for smooth look
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text('Corn',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 22),
                            Row(
                              children: [
                                Container(
                                  width: 77,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: borderColor, width: 1)),
                                  child: Center(
                                    child: Text(
                                      "Worker",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    print("edit it");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditFarm(farm: widget.farms)));
                                  },
                                  child: Image.asset('assets/images/edit.png',
                                      width: 30, height: 30),
                                ),
                                SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    print("delete it");
                                  },
                                  child: Image.asset('assets/images/delete.png',
                                      width: 30, height: 30),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ))),
            SizedBox(height: 24),
          ],
        )
      ]),
    );
  }

  // Function to build the empty state
  Widget _buildEmptyState(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Farms & Fields Management",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: "manrope",
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "You don’t have any farms yet",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: "manrope",
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Add farm logic here
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewFarm(
                              onInputChanged: _onInputChanged,
                            )));
                setState(() {
                  tell = true;
                });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text(
                "Add New Farm",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "manrope",
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(207, 54),
                backgroundColor: Color(0xFF1E6930),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
