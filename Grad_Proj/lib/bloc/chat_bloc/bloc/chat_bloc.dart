import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grd_proj/bloc/chat_bloc/bloc/chat_state.dart';
import 'package:grd_proj/service/signalR/signalr_service.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String token;
  final String userId;
  final String baseUrl;
  final SignalRService signalR;

  ChatBloc({
    required this.token,
    required this.userId,
    required this.baseUrl,
    required this.signalR,
  }) : super(const ChatState()) {
    on<StartConnectionEvent>(_onStartConnection);
    on<LoadConversationsEvent>(_onLoadConversations);
    on<SelectConversationEvent>(_onSelectConversation);
    on<MessageReceivedEvent>(_onMessageReceived);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onStartConnection(StartConnectionEvent event, Emitter<ChatState> emit) async {
    try {
      await signalR.connect();
      signalR.onMessageReceived((msg) {
        add(MessageReceivedEvent(msg));
      });
      emit(state.copyWith(isConnected: true));
      print("SignalR Connected");
    } catch (e) {
      print("SignalR connection failed: $e");
    }
  }

  Future<void> _onLoadConversations(LoadConversationsEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/conversations"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        final list = jsonDecode(res.body) as List;
        final conversations = list.cast<Map<String, dynamic>>();
        emit(state.copyWith(conversations: conversations, isLoading: false));
      } else {
        print("Failed to load conversations: ${res.statusCode}");
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print("Error loading conversations: $e");
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onSelectConversation(SelectConversationEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(
      selectedConversationId: event.conversationId,
      messages: [],
      isLoading: true,
    ));

    try {
      final res = await http.get(
        Uri.parse("$baseUrl/conversations/${event.conversationId}/messages"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        final list = jsonDecode(res.body) as List;
        final messages = list.cast<Map<String, dynamic>>();
        emit(state.copyWith(messages: messages, isLoading: false));

        // اشترك في المحادثة على SignalR
        await signalR.subscribeToConversation(event.conversationId);
        print("Subscribed to conversation ${event.conversationId}");

      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print("Error loading messages: $e");
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onMessageReceived(MessageReceivedEvent event, Emitter<ChatState> emit) {
    final updatedMessages = [...state.messages, event.message];
    emit(state.copyWith(messages: updatedMessages));
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      await signalR.sendMessage(event.message);
      print("Message sent");
    } catch (e) {
      print("❌ Failed to send message: $e");
    }
  }

  @override
  Future<void> close() async {
    await signalR.disconnect();
    return super.close();
  }
}
