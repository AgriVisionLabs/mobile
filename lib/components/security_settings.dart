// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({super.key});

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {

bool isEditingPassword = false;
bool isPasswordVisible = false;
bool isSwitched = false;
String originalPassword = 'Zdwrcexd11#';
TextEditingController passwordController = TextEditingController();

@override
void initState() {
  super.initState();
  passwordController.text = "";
}

  @override
  Widget build(BuildContext context) {
    return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ Row(
                    children: [
                    Image.asset('assets/images/shield.png',
                    width: 24,
                    height: 24),
                    SizedBox(width: 4,),
                    Text('Security Settings',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "manrope",
                    ))
                  ]),
                  SizedBox(height: 4),
                  Text('Manage your account security and authentication methods.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontFamily: "manrope",
                  )),
                  SizedBox(height:30),
                  Row(
                    children: [
                    SizedBox(
                      width: 231,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Two-Factor Authentication',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                          ),
                          ),
                          SizedBox(height: 8),
                          Text('Add an extra layer of security to your account.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                            )
                          )
                        ]),
                    ),
                      SizedBox(width: 50),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey[200],
                        activeTrackColor: primaryColor,
                      )
                  ]),
                  SizedBox(height: 24),
                  Divider(
                    thickness: 1,
                    color: borderColor,
                  ),
                  SizedBox(height: 24),
                  Text('Password',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: "manrope",
                  )),
                  SizedBox(height: 24),
                  !isEditingPassword
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '•' * originalPassword.length, // شكل مشفّر
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isEditingPassword = true;
                                isPasswordVisible = false;
                                passwordController.text = originalPassword;
                              });
                            },
                            child: Container(
                              height: 39,
                              width: 160,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xff333333), width: 1),
                              ),
                              child: Center(
                                  child: Text(
                                    'Change Password',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "manrope",
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: passwordController,
                            obscureText: !isPasswordVisible,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "manrope",
                            ),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    originalPassword = passwordController.text;
                                    isEditingPassword = false;
                                    isPasswordVisible = false;
                                  });
                                },
                                icon: Image.asset('assets/images/check.png',
                                      width: 24, height: 24),
                                  label: Text("Save",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: "manrope",
                                      fontWeight: FontWeight.w600
                                    ),),
                                ),
                                
                              SizedBox(width: 50),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    passwordController.text = "";
                                    isEditingPassword = false;
                                    isPasswordVisible = false;
                                  });
                                },
                                  icon: Image.asset('assets/images/wrong.png',
                                    width: 24, height: 24),
                                  label: Text("Cancel",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: "manrope",
                                      fontWeight: FontWeight.w600
                                    ),),
                                ),
                            ],
                          ),
                        ],
                      ),

                  SizedBox(height: 24),
                  Divider(color: borderColor),
                  SizedBox(height: 24),

                  Text('Last Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: "manrope",
                  )),
                  SizedBox(height: 24),
                  Text('April 18, 2025, 2:45 PM',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "manrope",)
                  ),

                  SizedBox(height: 24),
                  Divider(color: borderColor),
                  SizedBox(height: 24),

                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 54,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: borderColor, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/logout.png',
                          width: 24, height: 24),
                          SizedBox(width: 4),
                          Text('Logout from all devices',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "manrope",
                          ),)
                      ],),
                    ),
                    ),
                  ]));
  }
}
