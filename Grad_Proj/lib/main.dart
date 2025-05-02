// ignore_for_file: use_super_parameters, prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/core/api/dio_consumer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/user_cubit.dart';
import 'screens/register.dart';
import 'screens/splash_screen.dart';

// ignore: prefer_const_declarations
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp(
    BlocProvider(
      create: (context) =>
          UserCubit(DioConsumer(dio : Dio())),
      child: const MyApp(),
    ),);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}