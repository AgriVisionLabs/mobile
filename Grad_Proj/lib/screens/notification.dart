// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _cleared = false;
  bool _markedRead = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30), // Space for the top bar
          Container(
            height: 72,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF9F9F9F).withOpacity(0.5),
                ),
              ),
            ),
            child: Row(
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, size: 24),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10),
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                if (!_cleared && !_markedRead) // ✅ يظهر فقط لو فيه إشعار جديد
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 58,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '1 new',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ),
                ],
              ),
          ),
          if (_cleared)
            Center(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 270),
                Image.asset(
                  'assets/images/triangle_alert.png',
                  width: 24,
                  height: 24,
                ),
                SizedBox(height: 24),
                Text(
                  'There is No Notification ',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              ),
            )
          else
            ..._buildNotifications(),
          Spacer(),
          Container(
            height: 92,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _markedRead = true;
                    });
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(170, 45),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: borderColor),
                    ),
                  ),
                  child: Text(
                    'Mark All Read ',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _cleared = true;
                    });
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(170, 45),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: borderColor),
                    ),
                  ),
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      color: Color(0xffE13939),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNotifications() {
    return [
      _markedRead ? _buildNormalTile(
        icon: 'assets/images/circle_check_green.png',
        title: 'Harvest Ready',
        desc: 'Corn Field crop has reached optimal harvest conditions.',
        time: '1 hour ago',
      ) : _buildHighlightTile(),
      _buildNormalTile(
        icon: 'assets/images/yellow_alert.png',
        title: 'Soil Analysis Complete',
        desc: 'Lab results for Tech Farm soil samples are now available for review.',
        time: '2 hour ago',
      ),
      _buildNormalTile(
        icon: 'assets/images/PSitting.png',
        title: 'Equipment Maintenance Due',
        desc: 'Tractor #3 scheduled maintenance is overdue by 5 days.',
        time: '4 hour ago',
      ),
    ];
  }

  Widget _buildHighlightTile() {
    return Container(
      height: 159,
      width: double.infinity,
      color: Color(0xffF0FDF4),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/circle_check_green.png', width: 24, height: 24),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Harvest Ready',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Corn Field crop has reached optimal harvest conditions.',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff616161),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("1 hour ago",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.bold,
                          color: Color(0xff616161),
                        ),
                      ),
                        GestureDetector(
                        onTap: () {
                          setState(() {
                          _markedRead = true;
                          });
                        },
                        child: Text(
                          'Mark Read',
                          style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                          ),
                        ),
                        )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalTile({
    required String icon,
    required String title,
    required String desc,
    required String time,
  }) {
    return Container(
      height: 159,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF9F9F9F).withOpacity(0.5)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(icon, width: 24, height: 24),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(desc,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff616161),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(time,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff616161),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}