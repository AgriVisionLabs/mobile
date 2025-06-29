// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool systemSwitched = true;
  bool updatessSwitched = true;
  bool tipsSwitched = true;

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
            Image.asset('assets/images/bell.png', width: 24, height: 24),
            SizedBox(
              width: 4,
            ),
            Text('Notifications',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "manrope",
                ))
          ]),
          SizedBox(height: 4),
          Text('Control what notifications you receive and how they are delivered.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontFamily: "manrope",
              )),
          SizedBox(height: 30),
          Row(children: [
            SizedBox(
              width: 231,
              height: 94,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('System Alerts',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "manrope",
                )),
                SizedBox(height: 8),
                Text('Receive notifications about invites, irrigation failures, and system status',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff9F9F9F),
                      fontWeight: FontWeight.w600,
                      fontFamily: "manrope",
                )),
              ],),
            ),
<<<<<<< HEAD
            SizedBox(width: 35),
=======
            SizedBox(width: 50),
>>>>>>> 4478f5257086268166f8313285bc7f2fd1019bb0
            Switch(
              value: systemSwitched,
              onChanged: (value) {
                setState(() {
                  systemSwitched = value;
                });
              },
              activeColor: Colors.white,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[200],
              activeTrackColor: primaryColor,
            ),
          ],),

          SizedBox(height: 24),
          Divider(color: borderColor, thickness: 1,),
          SizedBox(height: 24),

          Row(children: [
            SizedBox(
              width: 231,
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Updates & Announcements',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "manrope",
                )),
                SizedBox(height: 8),
                Text('Stay informed about new features, improvements, and important announcements',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff9F9F9F),
                      fontWeight: FontWeight.w600,
                      fontFamily: "manrope",
                )),
              ],),
            ),
<<<<<<< HEAD
            SizedBox(width: 35),
=======
            SizedBox(width: 50),
>>>>>>> 4478f5257086268166f8313285bc7f2fd1019bb0
            Switch(
              value: updatessSwitched ,
              onChanged: (value) {
                setState(() {
                  updatessSwitched = value;
                });
              },
              activeColor: Colors.white,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[200],
              activeTrackColor: primaryColor,
            ),
          ],),

          SizedBox(height: 24),
          Divider(color: borderColor, thickness: 1,),
          SizedBox(height: 24),

          Row(children: [
            SizedBox(
              width: 231,
              height: 94,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Tips & Best Practices',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "manrope",
                )),
                SizedBox(height: 8),
                Text('Receive helpful tips and best practices to get the most out of the platform',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff9F9F9F),
                      fontWeight: FontWeight.w600,
                      fontFamily: "manrope",
                )),
              ],),
            ),
<<<<<<< HEAD
            SizedBox(width: 35),
=======
            SizedBox(width: 50),
>>>>>>> 4478f5257086268166f8313285bc7f2fd1019bb0
            Switch(
              value: tipsSwitched ,
              onChanged: (value) {
                setState(() {
                  tipsSwitched = value;
                });
              },
              activeColor: Colors.white,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[200],
              activeTrackColor: primaryColor,
            ),
          ],),

          SizedBox(height: 24),
          Divider(color: borderColor, thickness: 1,),
          SizedBox(height: 24),

          GestureDetector(
            onTap: () {
              setState(() {
                systemSwitched = false;
                updatessSwitched = false;
                tipsSwitched = false;
              });
            },
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
                  Text('Disable All Notifications',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "manrope",
                  ),)
              ],),
            ),
            ),
        ]
      )
    );
  }
}
