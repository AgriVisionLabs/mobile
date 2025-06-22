// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/components/date_input_formatter.dart';

class NewTask extends StatelessWidget {
  const NewTask({super.key});

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
                      Text("Create New Task",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
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
                  Text("Add a new task to the selected farm.",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 21,),
                  Text("Task Title",
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter a descriptive title',
                        hintStyle: TextStyle(color: Colors.grey[400],
                        fontFamily: "Manrope",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!, width: 1.8),
                          borderRadius: BorderRadius.circular(70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1.8),
                          borderRadius: BorderRadius.circular(70),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text("Description",
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 130,
                    child: Expanded(
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      decoration: InputDecoration(
                        hintText: 'Enter detailes about the task',
                        hintStyle: TextStyle(color: Colors.grey[400],
                        fontFamily: "Manrope",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!, width: 1.8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1.8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  ),
                  SizedBox(height: 16,),
                  Text("Priority",
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16,),
//here we need dropdown menu number1
                  SizedBox(height: 16,),
                  Text("Field",
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
//here we need dropdown menu number2
                  SizedBox(height: 16,),
                  Text("Due Date",
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16,),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),
                        DateInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: 'DD/MM/YYYY',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.2),
                          borderRadius: BorderRadius.circular(70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[500]!, width: 1.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 97),
//After adding the dropdown menus make sure to add the buttons below are at the end of the screen by adjusting the previous sizedbox()
                  Row(
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
                            color: Colors.grey[700]!,
                            width: 1.8,
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
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 140,
                        height: 45,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      child: Center(
                        child: Text("Creat Task",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
