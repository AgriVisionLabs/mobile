// ignore_for_file: use_super_parameters, prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grd_proj/bloc/account_bloc/bloc/account_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/conversation/chat_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/conversation_repositry.dart';
import 'package:grd_proj/bloc/chat_bloc/message/message_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/message/message_event.dart';
import 'package:grd_proj/bloc/chat_bloc/message_repositry.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/bloc/sensor_bloc/sensor_bloc.dart';
import 'package:grd_proj/bloc/weather/bloc/weather_bloc.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/screens/chat_screen.dart';
import 'package:grd_proj/screens/field_view.dart';
import 'package:grd_proj/service/api/dio_consumer.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/screens/add_irrigation_unit.dart';
import 'package:grd_proj/screens/basic_info.dart';
import 'package:grd_proj/screens/edit_farm.dart';
import 'package:grd_proj/screens/farms_screen.dart';
import 'package:grd_proj/screens/home_screen.dart';
import 'package:grd_proj/screens/irrigation_control.dart';
import 'package:grd_proj/screens/login_screen.dart';
import 'package:grd_proj/screens/more_screen.dart';
import 'package:grd_proj/screens/new_farm.dart';
import 'package:grd_proj/screens/schedule_maintenance.dart';
import 'package:grd_proj/screens/sensor.dart';
import 'package:grd_proj/screens/sensor_and_devices.dart';
import 'package:grd_proj/screens/sensor_view.dart';
import 'package:grd_proj/screens/verification.dart';
import 'package:grd_proj/service/signalR/signalr_service.dart';
import 'package:grd_proj/service/signalR/signar_service_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'bloc/user_cubit.dart';
import 'screens/register.dart';
import 'screens/splash_screen.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    // Create Dio and DioConsumer instance
    final dio = Dio();
    final dioConsumer = DioConsumer(dio: dio);

    // Instantiate UserCubit
    final userCubit = UserCubit(dioConsumer);

    // Call refreshToken to renew token in background
    await userCubit.refreshToken();

    return Future.value(true);
  });
}

// ignore: prefer_const_declarations
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51Rj9rZP97SHnyUFZM55CofWijFSTuNDAfGYzJ0hMCuEpOQc3gmroPMDUr8R1jiKz4ba9B7q5OhuVzPYY5ufrgWgh003jXrSLDi'; // مفتاح من Stripe Dashboard
  await Stripe.instance.applySettings();
  await CacheHelper.init();

  runApp(
    MultiBlocProvider(
      // single Responsiblity
      providers: [
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(DioConsumer(dio: Dio())),
        ),
        BlocProvider<FarmBloc>(
          create: (BuildContext context) => FarmBloc(DioConsumer(dio: Dio())),
        ),
        BlocProvider<FieldBloc>(
          create: (BuildContext context) => FieldBloc(DioConsumer(dio: Dio())),
        ),
        BlocProvider<ControlBloc>(
          create: (BuildContext context) =>
              ControlBloc(DioConsumer(dio: Dio())),
        ),
        BlocProvider<AccountBloc>(
          create: (BuildContext context) =>
              AccountBloc(DioConsumer(dio: Dio())),
        ),
        BlocProvider<SensorBloc>(
          create: (BuildContext context) => SensorBloc(DioConsumer(dio: Dio())),
        ),
        BlocProvider<WeatherBloc>(
          create: (BuildContext context) => WeatherBloc(DioConsumer(dio: Dio())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  get farm => null;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userCubit = context.read<UserCubit>();

      // افحص إذا في Token محفوظ
      final token = CacheHelper.getData(key: ApiKey.token);
      if (token != null && token.isNotEmpty) {
        // تبدأ جدولة التجديد
        userCubit.startTokenRefreshTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:

          //     BlocProvider(
          // create: (_) => ChatBloc(
          //   token: CacheHelper.getData(key: 'token'),
          //   userId: CacheHelper.getData(key: 'id'),
          //   baseUrl: "https://api.agrivisionlabs.tech/hubs/conversations",
          //   signalR: SignalRService(token: CacheHelper.getData(key: 'token')),
          // )..add(StartConnectionEvent())..add(LoadConversationsEvent()),
          // child: ChatScreen(),
          //   )
          // ScheduleMaintenance()
          // SensorView()
          // SplashScreen()
          // LoginScreen(),
      // SplashScreen()
      HomeScreen()
      // ChatListScreen()
      // ChatScreen(),
    );
  }
}
