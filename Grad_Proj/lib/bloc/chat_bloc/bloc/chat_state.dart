part of 'chat_bloc.dart';

@immutable
abstract class ConversationState {}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<ConversationModel> conversations;
  ConversationLoaded(this.conversations);
}

class ConversationError extends ConversationState {
  final String message;
  ConversationError(this.message);
}
