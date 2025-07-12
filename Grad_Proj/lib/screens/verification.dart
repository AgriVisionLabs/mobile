// ignore_for_file: use_super_parameters, prefer_const_constructors, use_key_in_widget_constructors, unused_import, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/components/resend_button.dart';

class Verification extends StatefulWidget {
  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton
                (
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon : 
                Icon(Icons.close,   color: primaryColor, size: 34,),
                ),
            ],),
            SizedBox(height: 30,),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Color.fromARGB(50, 30, 105, 48),
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.center,
              child: Image.asset('assets/images/mail1.png',
                // fit: BoxFit.contain,
                width: 60,
                height: 60,
                ),
            ),
            SizedBox(height: 45),
            Text('Check your email',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontFamily: "Manrope",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Text('We have sent a verification link to:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[800],
                fontFamily: "Manrope",
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24),
            Text('8WgB0@example.com',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: "Manrope",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Text('Click the link in the email to verify your address.',
            textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[800],
                fontFamily: "Manrope",
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            ResendButton(),
            SizedBox(height: 30,),
            Text("Can't find the email? Check your spam folder.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontFamily: "Manrope",
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 40,)
          ],
        ),
      )
    );
  }
  
}