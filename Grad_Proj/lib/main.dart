// ignore_for_file: use_super_parameters, prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/core/api/dio_consumer.dart';
import 'package:grd_proj/screens/basic_info.dart';
import 'package:grd_proj/screens/edit_farm.dart';
import 'package:grd_proj/screens/farms_screen.dart';
import 'package:grd_proj/screens/home_screen.dart';
import 'package:grd_proj/screens/login_screen.dart';
import 'package:grd_proj/screens/new_farm.dart';
import 'bloc/user_cubit.dart';
import 'screens/register.dart';
import 'screens/splash_screen.dart';

// ignore: prefer_const_declarations
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp(
    MultiBlocProvider(
      
      // single Responsiblity
      providers: [
        BlocProvider<UserCubit>(
        create: (BuildContext context) => UserCubit(DioConsumer(dio : Dio())),
      ),
      BlocProvider<FarmBloc>(
        create: (BuildContext context) => FarmBloc(DioConsumer(dio : Dio())),
      )
],
      child: const MyApp(),
    ),);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  get farm => null;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
   void _onInputChanged(List value) {
    setState(() {
      widget.farm.add(value);
      // var currentIndex = index;
      print(widget.farm);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}