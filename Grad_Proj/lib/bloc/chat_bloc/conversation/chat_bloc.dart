// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/bloc/chat_bloc/conversation_repositry.dart';
import 'package:grd_proj/models/conversation_model.dart';
import 'package:grd_proj/service/errors/exception.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository repository;
  List<ConversationModel> _currentConversations = [];
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController memberController = TextEditingController();
  List<String> memberEmails = [];

  ConversationBloc(this.repository) : super(ConversationInitial()) {
    repository.setBlocListeners(this); // ربط SignalR مع Bloc

    on<LoadConversationsEvent>((event, emit) async {
      emit(ConversationLoading());

      try {
        final result = await repository.fetchConversations();
        if (result.isNotEmpty) {
          _currentConversations = result;
          emit(ConversationLoaded(_currentConversations));
        } else {
          emit(ConversationEmpty());
        }
        print("Loaded: ${_currentConversations.length} conversations");
      } on ServerException catch (e) {
        emit(ConversationError(e.errorModel.message)); // ✅ هنا
      } catch (e) {
        emit(ConversationError('Unexpected error occurred'));
      }
    });

    on<CreateConversationEvent>((event, emit) async {
      try {
        final newConv = await repository.createConversation(
          memberIds: memberEmails,
        );
        _currentConversations.insert(0, newConv);
        emit(ConversationAddSuccess(conversation: newConv));
      } on ServerException catch (e) {
        emit(ConversationAddFailure(e.errorModel.message));
      } catch (e) {
        emit(ConversationAddFailure('Failed to create conversation'));
      }
    });

    on<DeleteConversationEvent>((event, emit) async {
      try {
        await repository.deleteConversationEvent(
          convId: event.conversationId,
        );
        
        emit(ConversationDeleteSuccess());
      } on ServerException catch (e) {
        emit(ConversationDeleteFailure(e.errorModel.message));
      } catch (e) {
        emit(ConversationDeleteFailure('Failed to create conversation'));
      }
    });

    on<ViewConv>((event, emit) async {
      try {
        await repository.viewConv(
          convId: event.conversationId,
        );
        
        emit(ConversationViewSuccess());
      } on ServerException catch (e) {
        emit(ConversationViewFailure(e.errorModel.message));
      } catch (e) {
        emit(ConversationViewFailure('Failed to create conversation'));
      }
    });

    on<NewConversationEvent>((event, emit) async {
      _currentConversations.add(event.data);
      emit(ConversationAddSuccess(conversation: event.data));
    });
    on<UpdateConversationEvent>((event, emit) async {
      _currentConversations = _currentConversations.map((c) {
        return c.id == event.data.id ? event.data : c;
      }).toList();
      emit(ConversationLoaded(List.from(_currentConversations)));
    });

    on<RemoveConversationEvent>((event, emit) async {
      _currentConversations
          .removeWhere((element) => element.id == event.conversationId);
      emit(ConversationLoaded(List.from(_currentConversations)));
    });
  }
}
