// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

class ViewTask extends StatelessWidget {
  const ViewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Inspect Corn Growth",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Text("Created on May 15,2025 by Mohmed Omar",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 24,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    width: MediaQuery.sizeOf(context).width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Check The Corn Growth In The North Field And Document Any Issues.',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  Text("Field",
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      SizedBox(width: 12),
                      Image.asset(
                        "assets/images/location.png",
                        width: 24,
                        height: 24,
                        
                      ),
                      SizedBox(width: 5),
                      Text("Green Farm - Field 1",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24,),
                  Text("Due Date",
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      SizedBox(width: 12),
                      Image.asset(
                        "assets/images/calender.png",
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 5),
                      Text("May 20, 2025",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24,),
                  Text("Status",
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(children: [
                    SizedBox(width: 12),
                    Container(
                      height: 30,
                      width: 135,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: borderColor,
                          width: 1.8,
                        ),
                      ),
                      child: Text('Not Completed',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                  ),
                  SizedBox(height: 24,),
                  Text("Priority",
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(children: [
                    SizedBox(width: 12),
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Color(0xffF04444),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text('High',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,),
                    )
                  ]),
                  SizedBox(height: 24,),
                  Divider(
                    color: Colors.grey[400],
                    thickness: 1.5,
                  ),
                  SizedBox(height: 24,),
                  Text('Assigned To',
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                  )),
                  SizedBox(height: 8,),
                  Row(children: [
                    SizedBox(width: 12),
                    Image.asset('assets/images/person.png',
                      width: 50,
                      height: 50,),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mohamed Omar',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text('Manager',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      )
                  ]),
                  SizedBox(height: 24,),
                  Divider(
                    color: Colors.grey[400],
                    thickness: 1.5,
                  ),
                  SizedBox(height: 24,),
                  Text('Actions',
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),),
                    SizedBox(height: 16,),
                    Row(children: [
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 212,
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/images/white_check_mark.png',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 8),
                              const Text("Mark complete",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                    ),
                    SizedBox(height: 74,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 99,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey[600]!,
                            width: 1,
                          ),
                        ),
                      child: Center(
                        child: Text("Cancel",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ),
        ),
      );
    }
  }
