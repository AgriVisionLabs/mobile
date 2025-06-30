// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:flutter/services.dart';
import 'package:grd_proj/components/notfication_settings.dart';
import 'package:grd_proj/components/personal_settings.dart';
import 'package:grd_proj/components/security_settings.dart';
import 'package:grd_proj/components/subcreption_settings.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int selectedTab = 0;

  final List<String> tabs = [
  "Personal",
  "Security",
  "Subscription",
  "Notification",
];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: 
      Padding(
        padding: const EdgeInsets.fromLTRB(16,150,16,50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Settings",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: "manrope",
              ),),
              SizedBox(height: 30),
              Container(
                height: 62,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0x4dD9D9D9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(tabs.length, (index) {
                      final isSelected = selectedTab == index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0), // مسافة بين التابات
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 46,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                color: isSelected ? primaryColor : Colors.grey,
                                fontSize: 16,
                                fontFamily: "manrope-semi-bold",
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (selectedTab == 0) PersonalSetting(),
              // if (selectedTab == 1) SecuritySettings(),
              // if (selectedTab == 2) SubcreptionSetting(),
              // if (selectedTab == 3) NotificationSettings(),
          ]),
        )
      )
    );
  }
}