// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/bloc/chat_bloc/conversation_repositry.dart';
import 'package:grd_proj/models/conversation_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository repository;
  List<ConversationModel> _currentConversations = [];

  ConversationBloc(this.repository) : super(ConversationInitial()) {
    repository.setBlocListeners(this); // ربط SignalR مع Bloc

    on<LoadConversationsEvent>((event, emit) async {
      emit(ConversationLoading());

      try {
        final result = await repository.fetchConversations();
        _currentConversations = result;
        emit(ConversationLoaded(_currentConversations));
        print("Loaded: ${_currentConversations.length} conversations");
      } catch (e) {
        print("Error loading conversations: $e");
        emit(ConversationError('Failed to load conversations'));
      }
    });
    on<NewConversationEvent>((event, emit) async {
      _currentConversations.add(event.data);
      emit(ConversationLoaded(List.from(_currentConversations)));
    });
    on<UpdateConversationEvent>((event, emit) async {
      _currentConversations = _currentConversations.map((c) {
        return c.id == event.data.id ? event.data : c;
      }).toList();
      emit(ConversationLoaded(List.from(_currentConversations)));
    });

    on<RemoveConversationEvent>((event, emit) async {
      _currentConversations.removeWhere((element) => element.id == event.id);
      emit(ConversationLoaded(List.from(_currentConversations)));
    });
  }
}
