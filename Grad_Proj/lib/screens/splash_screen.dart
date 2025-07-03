// ignore_for_file: unused_import

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grd_proj/screens/home_screen.dart';
import 'package:grd_proj/screens/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login_Screen.dart';

bool isLoggedIn = false ;
class SplashScreen extends StatefulWidget{
  const SplashScreen ({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  with SingleTickerProviderStateMixin {
@override
  void initState () {
  super.initState();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  Future.delayed(const Duration(seconds:2 ), () async{
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>  isLoggedIn ? const HomeScreen() : const Onboarding(),
        ),
    );
  });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
    // ignore: sized_box_for_whitespace
    body: Container(
    height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
        SizedBox(
          height: 400,
          width: 400,
          child: Image.asset('assets/images/logo.png',),)
            
      ],) ,
    ),

    );
}
}

