
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:grd_proj/bloc/chat_bloc/message/message_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/message_repositry.dart';
import 'package:grd_proj/cache/cache_helper.dart';

import 'package:grd_proj/screens/message_screen.dart';
import 'package:grd_proj/service/api/dio_consumer.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/service/signalR/signar_service_message.dart';

class MessageContainer extends StatelessWidget {
  final String convId;
  final String name;
  final bool groupe;
  const MessageContainer({super.key, required this.convId, required this.name, required this.groupe});

 

  @override
  Widget build(BuildContext context) {
    final token = CacheHelper.getData(key: ApiKey.token);


    final signalRM = MessageSignalRService(jwtToken: token);
    signalRM.init(convId);

    final messageRepo = MessageRepository(DioConsumer(dio: Dio()), signalRM);



    final messageBloc = MessageBloc(messageRepo);
    messageRepo.setBlocListeners(messageBloc);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: messageBloc),
      ],
      child: ChatDetailScreen(conversationId: convId, name: name, groupe: groupe,), // نفس الكلاس اللي كتبتيه فوق
    );
  }
}