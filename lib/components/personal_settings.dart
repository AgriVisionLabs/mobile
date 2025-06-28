// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grd_proj/components/color.dart';

class PersonalSetting extends StatefulWidget {
  const PersonalSetting({super.key});

  @override
  State<PersonalSetting> createState() => _PersonalSettingState();
}

class _PersonalSettingState extends State<PersonalSetting> {
  bool isEditingFirstName = false;
  bool isEditingLastName = false;
  bool isEditingUsername = false;
  bool isEditingEmail = false;
  bool isEditingPhone = false;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  String originalFirstName = "Hussein";
  String originalLastName = "Ahmed";
  String originalUsername = "hussein_123";
  String originalEmail = "hussein@gmail.com";
  String originalPhone = "01012345678";

  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey.shade400),
  );

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: originalFirstName);
    lastNameController = TextEditingController(text: originalLastName);
    usernameController = TextEditingController(text: originalUsername);
    emailController = TextEditingController(text: originalEmail);
    phoneController = TextEditingController(text: originalPhone);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Image.asset('assets/images/black_person_icon.png',
              width: 24, height: 24),
          SizedBox(
            width: 4,
          ),
          Text('Personal Information',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: "manrope",
              ))
        ]),
        SizedBox(height: 4),
        Text('Manage your personal details and contact information.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontFamily: "manrope",
            )),
        SizedBox(height: 30),
        Text('Profile Picture',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: "manrope",
            )),
        SizedBox(height: 24),
        Row(children: [
          Image.asset('assets/images/person.png', width: 50, height: 50),
          SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Upload new picture',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff616161),
                      fontWeight: FontWeight.bold,
                      fontFamily: "manrope")),
              SizedBox(height: 8),
              Text('Remove',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffE13939),
                    fontWeight: FontWeight.bold,
                    fontFamily: "manrope",
                  ))
            ],
          )
        ]),
        SizedBox(height: 24),
        Divider(
          color: borderColor,
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Text(
              'First Name',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: "manrope",
              ),
            ),
            Spacer(),
            if (!isEditingFirstName)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEditingFirstName = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/edit.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 4),
                      Text('Edit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                          )),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 24),
        isEditingFirstName
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: borderColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            isEditingFirstName = false;
                          });
                        },
                        icon: Image.asset('assets/images/check.png',
                            width: 24, height: 24),
                        label: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 50),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            firstNameController.text = originalFirstName;
                            isEditingFirstName = false;
                          });
                        },
                        icon: Image.asset('assets/images/wrong.png',
                            width: 24, height: 24),
                        label: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Text(
                firstNameController.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: "manrope",
                ),
              ),
        SizedBox(height: 24),
        Divider(
          color: borderColor,
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Text(
              'Last Name',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "manrope"),
            ),
            Spacer(),
            if (!isEditingLastName)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEditingLastName = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/edit.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 4),
                      Text('Edit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                          )),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 24),
        isEditingLastName
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: lastNameController,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "manrope",
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                            isEditingLastName = false;
                          });
                        },
                        icon: Image.asset('assets/images/check.png',
                            width: 24, height: 24),
                        label: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 50),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            lastNameController.text = originalLastName;
                            isEditingLastName = false;
                          });
                        },
                        icon: Image.asset('assets/images/wrong.png',
                            width: 24, height: 24),
                        label: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Text(
                lastNameController.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: "manrope",
                ),
              ),
        SizedBox(height: 24),
        Divider(
          color: borderColor,
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Text(
              'Username',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "manrope"),
            ),
            Spacer(),
            if (!isEditingUsername)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEditingUsername = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/edit.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 4),
                      Text('Edit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                          )),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 24),
        isEditingUsername
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: usernameController,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "manrope",
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                            isEditingUsername = false;
                          });
                        },
                        icon: Image.asset('assets/images/check.png',
                            width: 24, height: 24),
                        label: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 50),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            usernameController.text = originalUsername;
                            isEditingUsername = false;
                          });
                        },
                        icon: Image.asset('assets/images/wrong.png',
                            width: 24, height: 24),
                        label: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Text(
                usernameController.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: "manrope",
                ),
              ),
        SizedBox(height: 24),
        Divider(
          color: borderColor,
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Text(
              'Email',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "manrope"),
            ),
            Spacer(),
            if (!isEditingEmail)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEditingEmail = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/edit.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 4),
                      Text('Edit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                          )),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 24),
        isEditingEmail
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: emailController,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "manrope",
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                            isEditingEmail = false;
                          });
                        },
                        icon: Image.asset('assets/images/check.png',
                            width: 24, height: 24),
                        label: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 50),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            emailController.text = originalEmail;
                            isEditingEmail = false;
                          });
                        },
                        icon: Image.asset('assets/images/wrong.png',
                            width: 24, height: 24),
                        label: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Text(
                emailController.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: "manrope",
                ),
              ),
        SizedBox(height: 24),
        Divider(
          color: borderColor,
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Text(
              'Phone',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "manrope"),
            ),
            Spacer(),
            if (!isEditingPhone)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEditingPhone = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/edit.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 4),
                      Text('Edit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                          )),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 24),
        isEditingPhone
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // الكود الدولي
                      Container(
                        height: 52,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: ShapeDecoration(
                          shape: borderStyle,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "+20",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "manrope",
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      // الرقم
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "manrope",
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            border: borderStyle,
                            enabledBorder: borderStyle,
                            focusedBorder: borderStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            isEditingPhone = false;
                          });
                        },
                        icon: Image.asset('assets/images/check.png',
                            width: 24, height: 24),
                        label: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 50),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            phoneController.text = originalPhone;
                            isEditingPhone = false;
                          });
                        },
                        icon: Image.asset('assets/images/wrong.png',
                            width: 24, height: 24),
                        label: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  Text(
                    "+20 ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "manrope",
                    ),
                  ),
                  Text(
                    phoneController.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "manrope",
                    ),
                  ),
                ],
              ),
      ]),
    );
  }
}
