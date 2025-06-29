// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/farm_list.dart';
import 'package:grd_proj/screens/new_task.dart';
import 'package:grd_proj/screens/view_task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreen();
}

class _TaskScreen extends State<TaskScreen> {
  late TextEditingController controller;
  String? selectedValue;
  int selectedTab = 0;
  @override
  void initState() {
    super.initState();
    selectedValue = farmList[0];
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18),
                      Row(
                        children: [
                          Text(
                            'Tasks',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontFamily: 'manrope-medium',
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => NewTask()));
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                        width: 290,
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
                            width: 24,
                            height: 24,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          items: farmList.map((farm) {
                            return DropdownMenuItem(
                              value: farm,
                              child: Text(
                                farm,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 62,
                        width: 370,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                        color: const Color(0x4dD9D9D9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(3, (index) {
                            final List<String> tabs = [
                              "All Tasks",
                              "My Tasks",
                              "Completed Tasks"
                            ];
                            final isSelected = selectedTab == index;
                            return Padding(
                            padding: const EdgeInsets.symmetric(horizontal:5),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTab = index;
                                  });
                                },
                                child: Container(
                                  height: 46,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    tabs[index],
                                    style: TextStyle(
                                      color: isSelected
                                          ? primaryColor
                                          : Colors.grey,
                                      fontSize: 16,
                                      fontFamily: "manrope-semi-bold",
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    ),
                      SizedBox(height: 20),
                      if (selectedTab == 0)...[               
                      Column(
                        children: [
                          SizedBox(height: 16),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(-1, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 240,
                                        child: Text(
                                          'Inspect Corn Growth',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'manrope-semi-bold',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 51,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF04444),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'High',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'manrope-semi-bold',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/location.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Green Farm - Field 1',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontFamily: 'manrope-regular',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 100,
                                      maxHeight: 100,
                                    ),
                                    child: Scrollbar(
                                      thumbVisibility: false,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        reverse: true,
                                        child: TextField(
                                          controller: TextEditingController(
                                            text: "Check the corn growth in the north field and document any issues.",
                                          ),
                                          readOnly: true,
                                          maxLines: null,
                                          textAlign: TextAlign.start,
                                          textAlignVertical: TextAlignVertical.top,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            isCollapsed: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: 'manrope-medium',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/person_icon.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Mohmed Omar',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontFamily: 'manrope-bold',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/calender.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Jun 15, 2025',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontFamily: 'manrope-bold',
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                SizedBox(height: 24),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ViewTask()),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/eye.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          print('completed');
                                        });
                                      },
                                      child: Image.asset(
                                        'assets/images/circle_check.png',
                                        width: 34,
                                        height: 34,
                                      ),
                                    )
                                  ],
                                ),
                                ],
                              )),
                          SizedBox(height: 24),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(-1, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 222,
                                    child: Text(
                                      'Apply Fertilizer',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'manrope-semi-bold',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 74,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF4731C),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Medium',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'manrope-semi-bold',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/location.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Green Farm - Field 2',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontFamily: 'manrope-regular',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 100,
                                  maxHeight: 100,
                                ),
                                child: Scrollbar(
                                  thumbVisibility: false,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: TextField(
                                      controller: TextEditingController(
                                        text: "Apply nitrogen fertilizer to the south field according to the schedule.",
                                      ),
                                      readOnly: true,
                                      maxLines: null,
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.top,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontFamily: 'manrope-medium',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/person_icon.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Yousef Mahmoud',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontFamily: 'manrope-bold',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/calender.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Jun 15, 2025',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontFamily: 'manrope-bold',
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 24),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            SizedBox(height: 24),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ViewTask()),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/eye.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      print('completed');
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/images/circle_check.png',
                                    width: 34,
                                    height: 34,
                                  ),
                                )
                              ],
                            ),
                            ],
                          )),
                          SizedBox(height: 24),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(-1, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 240,
                                      child: Text(
                                        'Repair Irrigation System',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'manrope-semi-bold',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 47,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xff25C462),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Low',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'manrope-semi-bold',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/location.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Green Farm - Field 3',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: 'manrope-regular',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 100,
                                    maxHeight: 100,
                                  ),
                                  child: Scrollbar(
                                    thumbVisibility: false,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      reverse: true,
                                      child: TextField(
                                        controller: TextEditingController(
                                          text: "Fix the broken sprinkler in the east field section B.",
                                        ),
                                        readOnly: true,
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        textAlignVertical: TextAlignVertical.top,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          isCollapsed: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'manrope-medium',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                                Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/person_icon.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Hussein Mohamed',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontFamily: 'manrope-bold',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/calender.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Jun 15, 2025',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontFamily: 'manrope-bold',
                                      ),
                                    ),]),
                              SizedBox(height: 24),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              SizedBox(height: 24),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ViewTask()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/eye.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        print('completed');
                                      });
                                    },
                                    child: Image.asset(
                                      'assets/images/circle_check.png',
                                      width: 34,
                                      height: 34,
                                    ),
                                  )
                                ],
                              ),
                              ],
                            )),
                          SizedBox(height: 24),
                        ],
                      ),
                      ],
                      if (selectedTab == 1)...[                     
                      Column(
                        children: [
                          SizedBox(height: 16),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(-1, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 240,
                                        child: Text(
                                          'Inspect Corn Growth',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'manrope-semi-bold',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 51,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF04444),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'High',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'manrope-semi-bold',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/location.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Green Farm - Field 1',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontFamily: 'manrope-regular',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 100,
                                      maxHeight: 100,
                                    ),
                                    child: Scrollbar(
                                      thumbVisibility: false,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        reverse: true,
                                        child: TextField(
                                          controller: TextEditingController(
                                            text: "Check the corn growth in the north field and document any issues.",
                                          ),
                                          readOnly: true,
                                          maxLines: null,
                                          textAlign: TextAlign.start,
                                          textAlignVertical: TextAlignVertical.top,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            isCollapsed: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: 'manrope-medium',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/person_icon.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Mohmed Omar',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontFamily: 'manrope-bold',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/calender.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Jun 15, 2025',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontFamily: 'manrope-bold',
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                SizedBox(height: 24),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ViewTask()),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/eye.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          print('completed');
                                        });
                                      },
                                      child: Image.asset(
                                        'assets/images/circle_check.png',
                                        width: 34,
                                        height: 34,
                                      ),
                                    )
                                  ],
                                ),
                                ],
                              )),
                          SizedBox(height: 24),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(-1, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 222,
                                    child: Text(
                                      'Apply Fertilizer',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'manrope-semi-bold',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 74,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF4731C),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Medium',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'manrope-semi-bold',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/location.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Green Farm - Field 2',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontFamily: 'manrope-regular',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 100,
                                  maxHeight: 100,
                                ),
                                child: Scrollbar(
                                  thumbVisibility: false,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: TextField(
                                      controller: TextEditingController(
                                        text: "Apply nitrogen fertilizer to the south field according to the schedule.",
                                      ),
                                      readOnly: true,
                                      maxLines: null,
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.top,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontFamily: 'manrope-medium',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/person_icon.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Yousef Mahmoud',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontFamily: 'manrope-bold',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/calender.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Jun 15, 2025',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontFamily: 'manrope-bold',
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 24),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            SizedBox(height: 24),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ViewTask()),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/eye.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      print('completed');
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/images/circle_check.png',
                                    width: 34,
                                    height: 34,
                                  ),
                                )
                              ],
                            ),
                            ],
                          )),
                          SizedBox(height: 24),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(-1, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 240,
                                      child: Text(
                                        'Repair Irrigation System',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'manrope-semi-bold',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 47,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xff25C462),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Low',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'manrope-semi-bold',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/location.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Green Farm - Field 3',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: 'manrope-regular',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 100,
                                    maxHeight: 100,
                                  ),
                                  child: Scrollbar(
                                    thumbVisibility: false,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      reverse: true,
                                      child: TextField(
                                        controller: TextEditingController(
                                          text: "Fix the broken sprinkler in the east field section B.",
                                        ),
                                        readOnly: true,
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        textAlignVertical: TextAlignVertical.top,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          isCollapsed: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'manrope-medium',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                                Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/person_icon.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Hussein Mohamed',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontFamily: 'manrope-bold',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/calender.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Jun 15, 2025',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontFamily: 'manrope-bold',
                                      ),
                                    ),]),
                              SizedBox(height: 24),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              SizedBox(height: 24),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ViewTask()),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/eye.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        print('completed');
                                      });
                                    },
                                    child: Image.asset(
                                      'assets/images/circle_check.png',
                                      width: 34,
                                      height: 34,
                                    ),
                                  )
                                ],
                              ),
                              ],
                            )),
                          SizedBox(height: 24),
                        ],
                      ),
                      ],
                      if (selectedTab == 2)...[
                      Column(
                        children: [
                          SizedBox(height: 16),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(-1, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Inspect Corn Growth',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'manrope-semi-bold',
                                          color: Colors.black,
                                        ),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        'assets/images/circle_check_green.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/location.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Green Farm - Field 1',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontFamily: 'manrope-regular',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 100,
                                      maxHeight: 100,
                                    ),
                                    child: Scrollbar(
                                      thumbVisibility: false,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        reverse: true,
                                        child: TextField(
                                          controller: TextEditingController(
                                            text: "Check the corn growth in the north field and document any issues.",
                                          ),
                                          readOnly: true,
                                          maxLines: null,
                                          textAlign: TextAlign.start,
                                          textAlignVertical: TextAlignVertical.top,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            isCollapsed: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: 'manrope-medium',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/person_icon.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Mohmed Omar',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontFamily: 'manrope-bold',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/calender.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Jun 15, 2025',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontFamily: 'manrope-bold',
                                        ),
                                      ),
                                    ],
                                  ),
                                
                                ],
                              )),
                          SizedBox(height: 24),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(-1, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Apply Fertilizer',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'manrope-semi-bold',
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  Image.asset(
                                        'assets/images/circle_check_green.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/location.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Green Farm - Field 2',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontFamily: 'manrope-regular',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 100,
                                  maxHeight: 100,
                                ),
                                child: Scrollbar(
                                  thumbVisibility: false,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: TextField(
                                      controller: TextEditingController(
                                        text: "Apply nitrogen fertilizer to the south field according to the schedule.",
                                      ),
                                      readOnly: true,
                                      maxLines: null,
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.top,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontFamily: 'manrope-medium',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/person_icon.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Hussein Mohamed',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontFamily: 'manrope-bold',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/calender.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Jun 15, 2025',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontFamily: 'manrope-bold',
                                      ),
                                    ),]),
                            
                            ],
                          )),
                          SizedBox(height: 24),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(-1, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 240,
                                      child: Text(
                                        'Repair Irrigation System',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'manrope-semi-bold',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                        'assets/images/circle_check_green.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/location.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Green Farm - Field 3',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: 'Manrope',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 100,
                                    maxHeight: 100,
                                  ),
                                  child: Scrollbar(
                                    thumbVisibility: false,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      reverse: true,
                                      child: TextField(
                                        controller: TextEditingController(
                                          text: "Fix the broken sprinkler in the east field section B.",
                                        ),
                                        readOnly: true,
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        textAlignVertical: TextAlignVertical.top,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          isCollapsed: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'manrope-medium',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                children: [
                                  Image.asset(
                                    'assets/images/person_icon.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Yousef Mahmoud',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontFamily: 'manrope-bold',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/calender.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Jun 15, 2025',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontFamily: 'manrope-bold',
                                    ),
                                  ),
                                ],
                              ),
                              
                              ],
                            )),
                          SizedBox(height: 24),
                        ],
                      ),
                      ],
                    ],
                  ),
                ],
              ))),
    );
  }
}
