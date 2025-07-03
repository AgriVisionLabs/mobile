// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/home_screen.dart';
import 'package:grd_proj/screens/widget/text.dart';

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
                        Image.asset('assets/images/ph_drop.png',
                            color: imgColor, width: 35, height: 35),
                        SizedBox(height: 12),
                        text(fontSize: 18, label: 'Irrigation')
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
                        Image.asset('assets/images/bug.png',
                            width: 35, height: 35),
                        SizedBox(height: 12),
                        text(fontSize: 18, label: 'Disease Detection')
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
                        Image.asset('assets/images/sensor.png',
                            width: 35, height: 35),
                        SizedBox(height: 12),
                        text(fontSize: 18, label: 'Sensors and devices')
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
                                  initialIndex: 9,
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
                        Image.asset('assets/images/invet.png',
                            width: 35, height: 35),
                        SizedBox(height: 12),
                        text(fontSize: 18, label: 'Inventory')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 22,
            ),
            Row(
              children: [
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
                        Image.asset('assets/images/chat.png',
                            width: 35, height: 35),
                        SizedBox(height: 12),
                        text(fontSize: 18, label: 'Chat')
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
                        Image.asset('assets/images/settings (2).png',
                            width: 35, height: 35),
                        SizedBox(height: 12),
                        text(fontSize: 18, label: 'Settings')
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
