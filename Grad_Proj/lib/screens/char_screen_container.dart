import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:grd_proj/bloc/chat_bloc/conversation/chat_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/conversation_repositry.dart';
import 'package:grd_proj/bloc/chat_bloc/message/message_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/message_repositry.dart';
import 'package:grd_proj/cache/cache_helper.dart';

import 'package:grd_proj/screens/chat_screen.dart';
import 'package:grd_proj/service/api/dio_consumer.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/service/signalR/signalr_service.dart';
import 'package:grd_proj/service/signalR/signar_service_message.dart';

class ChatListContainer extends StatelessWidget {
  const ChatListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final token = CacheHelper.getData(key: ApiKey.token);
    final userId = CacheHelper.getData(key: ApiKey.id);

    final signalR = ConversationSignalRService(jwtToken: token, userId: userId);
    final signalRM = MessageSignalRService(jwtToken: token);

    final conversationRepo =
        ConversationRepository(DioConsumer(dio: Dio()), signalR);
    final messageRepo = MessageRepository(DioConsumer(dio: Dio()), signalRM);

    final conversationBloc = ConversationBloc(conversationRepo);
    conversationRepo.setBlocListeners(conversationBloc);
    conversationBloc.add(LoadConversationsEvent());

    final messageBloc = MessageBloc(messageRepo);
    messageRepo.setBlocListeners(messageBloc);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: conversationBloc),
        BlocProvider.value(value: messageBloc),
      ],
      child: ChatListScreen(), // نفس الكلاس اللي كتبتيه فوق
    );
  }
}
