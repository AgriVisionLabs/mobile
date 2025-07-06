// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/chat.dart';
import 'package:grd_proj/screens/home_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreen();
}

class _MoreScreen extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
            ),
            SizedBox(height: 40),
            Text(
              'More Options',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontFamily: 'Manrope',
              ),
            ),
            SizedBox(height: 50),
            Row(
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
                    width: 180,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromARGB(135, 159, 159, 159),
                          width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3E9E9E9E),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 18),
                        Image.asset('assets/images/Irrigation.png',
                            width: 35, height: 35),
                        SizedBox(height: 12),
                        Text(
                          'Irrigation',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 32),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  initialIndex: 7,
                                )));
                  },
                  child: Container(
                    width: 180,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromARGB(135, 159, 159, 159),
                          width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3E9E9E9E),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 18),
                        Image.asset('assets/images/disease_detection.png',
                            width: 35, height: 35),
                        SizedBox(height: 12),
                        Text(
                          'Disease Detection',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  initialIndex: 6,
                                )));
                  },
                  child: Container(
                    width: 180,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromARGB(135, 159, 159, 159),
                          width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3E9E9E9E),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 18),
                        Image.asset('assets/images/Sensors_and_devices.png',
                            width: 35, height: 35),
                        SizedBox(height: 12),
                        Text(
                          'Sensors and devices',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 32),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  initialIndex: 8,
                                )));
                  },
                  child: Container(
                    width: 180,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromARGB(135, 159, 159, 159),
                          width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3E9E9E9E),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 18),
                        Image.asset('assets/images/Settings.png',
                            width: 35, height: 35),
                        SizedBox(height: 12),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatListScreen()));
                  },
                  child: Container(
                    width: 180,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromARGB(135, 159, 159, 159),
                          width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3E9E9E9E),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 18),
                        Image.asset('assets/images/Irrigation.png',
                            width: 35, height: 35),
                        SizedBox(height: 12),
                        Text(
                          'Irrigation',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
