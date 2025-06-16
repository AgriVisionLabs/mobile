// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grd_proj/screens/basic_info.dart';
import 'package:grd_proj/screens/review.dart';
import 'package:grd_proj/screens/team.dart';
import '../Components/color.dart';

class NewFarm extends StatefulWidget {
  final Function(List) onInputChanged;
  const NewFarm({super.key,required this.onInputChanged});

  @override
  State<NewFarm> createState() => _NewFarmState();
}

class _NewFarmState extends State<NewFarm> {
  int currentIndex = 0;
  List farm = [];
  void _onInputChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Top Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  top(),
                  const SizedBox(height: 40),
                  buildDots(),
                ],
              ),
            ),
            
            // Scrollable Form Section
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (currentIndex == 0)
                      BasicInfo(onInputChanged: _onInputChanged, currentIndex: currentIndex)
                    else if (currentIndex == 1)
                      Team(onInputChanged: _onInputChanged, currentIndex: currentIndex)
                    else
                      Review(farm: farm),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget top() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (currentIndex > 0) currentIndex--;
            });
          },
          
          icon:  Icon(Icons.arrow_back_rounded, color: currentIndex == 0 ? Colors.white: Color(0xff757575), size: 24),
        ),
        const Spacer(),
        const Text(
          'Add New Farm',
          style: TextStyle(
            fontFamily: 'Manrope',
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {
        Navigator.pop(context);
          },
          icon: const Icon(Icons.close_rounded, color: Color(0xff757575), size: 24),
        ),
      ],
    );
  }

  Widget buildIndicatorItem(int index) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: currentIndex == index
          ? primaryColor
          : const Color.fromRGBO(30, 105, 48, 0.25),
      child: Text(
        (index + 1).toString(),
        style: const TextStyle(
          fontFamily: 'Manrope',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildDots() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Column(
                children: [
                  buildIndicatorItem(index),
                  const SizedBox(height: 7),
                  Text(
                    index == 0 ? 'Basic Info' : index == 1 ? 'Team' : 'Review',
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              if (index < 2)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  width: 50,
                  height: 1,
                  color: const Color(0xFF333333),
                ),
            ],
          );
        },
      ),
    );
  }
}
