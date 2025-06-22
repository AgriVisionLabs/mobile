// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:grd_proj/models/farm_list.dart';
import '../Components/color.dart';

class IrrigationConrtol extends StatefulWidget {
  const IrrigationConrtol({super.key});

  @override
  State<IrrigationConrtol> createState() => _IrrigationConrtolState();
}

class _IrrigationConrtolState extends State<IrrigationConrtol> {
  String? selectedValue;
  String? selectedfield;
  String? selectedtype;
  String? selectedstatus;
  bool active = true;
  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
    selectedfield = fileds[0];
    selectedValue = farmList[0];
    selectedtype = rules_types[0];
    selectedstatus = rules_status[0];
  }
  

  List<String> fileds = [
    "Field 1",
    "Field 2",
    "Field 3",
    "Field 4",
    "Field 5",
  ];
  List<String> rules_types = [
    "Threshold",
    "Time-based",
    "Event-based",
  ];
  List<String> rules_status = ["inactive", "active"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 22, left: 16, right: 16),
        height: MediaQuery.sizeOf(context).height,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Irrigation Control",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "manrope",
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.2),
                          builder: (BuildContext context) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: const EdgeInsets.all(31),
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                padding: const EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 15,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.close,
                                              color: Colors.black),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            "Filter Irrigation Units And Automation Rules",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "manrope",
                                              color: primaryColor,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Text("Filter by Field",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "manrope",
                                          color: Colors.black,
                                        )),
                                    // DropdownButton(
                                    //   value: selectedfield,
                                    //   onChanged: (newvalue) {
                                    //     setState(() {
                                    //       selectedfield = newvalue;
                                    //     });
                                    //   },
                                    //   items: fileds.map((fileds) {
                                    //     return DropdownMenuItem(
                                    //       value: fileds,
                                    //       child: Text(fileds),
                                    //     );
                                    //   }).toList(),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFF333333),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Image.asset(
                              'assets/images/filter.png',
                              width: 24,
                              height: 24,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "manrope",
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Row(
                  children: [
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
                        items: farmList.map((farm) {
                          return DropdownMenuItem(
                            value: farm,
                            child: Text(farm),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Irrigation Units',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: "manrope",
                        color: Color(0xFF333333),
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
                          // Add your onPressed code here!
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),

                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: Color(0xff0D121C).withOpacity(0.25), width: 1),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(50, 0, 0, 0),
                            blurRadius: 15,
                            spreadRadius: 0.7,
                            offset: Offset(0, 2.25))
                      ]),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    width: 400,
                    height: 255,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Green Fram',
                                    style: TextStyle(
                                      color: Color(0xff1E6930),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "manrope",
                                    )),
                                Spacer(),
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
                                      active ? "Active" : "Inactive",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/location.png',
                                ),
                                SizedBox(width: 8),
                                Text("Field 1",
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
                                Image.asset(
                                  'assets/images/ha4tag.png',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(width: 8),
                                Text("SN001",
                                    style: TextStyle(
                                      color: Color(0xff0D121C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              color: Color(0xff0D121C).withOpacity(0.25),
                              thickness: 1,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("edit it");
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
                                Spacer(),
                                Switch(
                                  value: active,
                                  onChanged: (value) {
                                    setState(() {
                                      active = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: primaryColor,
                                  inactiveTrackColor: Colors.grey[300],
                                  inactiveThumbColor: Colors.white,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 24),
                // Container(
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(25),
                //         border: Border.all(color: Color(0xff0D121C).withOpacity(0.25),width: 1),
                //         boxShadow: const [BoxShadow(
                //           color: Color.fromARGB(50, 0, 0, 0),
                //           blurRadius: 15,
                //           spreadRadius: 0.7,
                //           offset: Offset(0, 2.25)
                //         )]
                //       ),
                //     child: Container(
                //         padding: const EdgeInsets.all(24),
                //         width: 400,
                //         height: 255,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(25),
                //         ),
                //         child: Column(
                //           children: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Row(
                //                   children: [
                //                     Text('Tech Fram',
                //                         style: TextStyle(
                //                           color: Color(0xff1E6930),
                //                           fontSize: 20,
                //                           fontWeight: FontWeight.bold,
                //                           fontFamily: "manrope",
                //                         )),
                //                         Spacer(),
                //                         Container(
                //                       width: 77,
                //                       height: 30,
                //                       decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           borderRadius: BorderRadius.circular(25),
                //                           border: Border.all(
                //                               color: borderColor, width: 1)),
                //                       child: Center(
                //                         child: Text(
                //                           active ? "Active": "Inactive",
                //                           style: TextStyle(
                //                               color: Colors.black,
                //                               fontSize: 16,
                //                               fontWeight: FontWeight.w400),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 SizedBox(height: 16),
                //                 Row(
                //                   children: [
                //                     Image.asset(
                //                       'assets/images/location.png',
                //                     ),
                //                     SizedBox(width: 8),
                //                     Text("Field 2",
                //                         style: TextStyle(
                //                           color: Color(0xff616161),
                //                           fontSize: 18,
                //                           fontWeight: FontWeight.w500,
                //                           fontFamily: "manrope",
                //                         )),
                //                   ],
                //                 ),
                //                 SizedBox(height: 16),
                //                 Row(
                //                   children: [
                //                     Image.asset(
                //                       'assets/images/ha4tag.png',
                //                       width: 24,
                //                       height: 24,
                //                     ),
                //                     SizedBox(width: 8),
                //                     Text("SN002",
                //                         style: TextStyle(
                //                           color: Color(0xff0D121C),
                //                           fontSize: 18,
                //                           fontWeight: FontWeight.w500,
                //                           fontFamily: "manrope",
                //                         )),
                //                   ],
                //                 ),
                //                 SizedBox(height: 10),
                //                 Divider(
                //                   color: Color(0xff0D121C).withOpacity(0.25),
                //                   thickness: 1,
                //                 ),
                //                 SizedBox(height: 10),
                //                 Row(
                //                   children: [
                //                       GestureDetector(
                //                       onTap: () {
                //                         print("edit it");
                //                       },
                //                       child: Image.asset('assets/images/edit.png',
                //                           width: 30, height: 30),
                //                     ),
                //                     SizedBox(width: 20),
                //                     GestureDetector(
                //                       onTap: () {
                //                         print("delete it");
                //                       },
                //                       child: Image.asset('assets/images/delete.png',
                //                           width: 30, height: 30),
                //                     ),
                //                     Spacer(),
                //                     Switch(
                //                         value: active,
                //                         onChanged: (value) {
                //                           setState(() {
                //                             active = value;
                //                           });
                //                         },
                //                         activeColor: Colors.white,
                //                         activeTrackColor: primaryColor,
                //                         inactiveTrackColor: Colors.grey[300],
                //                         inactiveThumbColor: Colors.white,
                //                         ),
                //                   ],
                //                 )
                //               ],
                //             )
                //           ],
                //         ),
                //         ),
                //         ),
                SizedBox(height: 44),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Automation Rules',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: "manrope",
                        color: Color(0xFF333333),
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
                          // Add your onPressed code here!
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),

                SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: Color(0xff0D121C).withOpacity(0.25), width: 1),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(50, 0, 0, 0),
                            blurRadius: 15,
                            spreadRadius: 0.7,
                            offset: Offset(0, 2.25))
                      ]),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    width: 400,
                    height: 275,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Morning Moisture Check',
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
                                  'assets/images/alert.png',
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(width: 8),
                                Text("Type : Threshold",
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
                                Image.asset(
                                  'assets/images/location.png',
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(width: 8),
                                Text("Field : Field 1",
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
                                Image.asset(
                                  'assets/images/Performance_indicators.png',
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(width: 8),
                                Text("Threshold : 50-80 %",
                                    style: TextStyle(
                                      color: Color(0xff616161),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "manrope",
                                    )),
                              ],
                            ),
                            Divider(
                              color: Color(0xff0D121C).withOpacity(0.25),
                              thickness: 1,
                            ),
                            Row(
                              children: [
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: primaryColor,
                                  inactiveTrackColor: Colors.grey[300],
                                  inactiveThumbColor: Colors.white,
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    print("edit it");
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
                    ),
                  ),
                ),
                SizedBox(height: 21),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
