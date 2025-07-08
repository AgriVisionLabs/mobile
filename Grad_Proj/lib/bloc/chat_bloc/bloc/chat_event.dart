part of 'chat_bloc.dart';

@immutable
abstract class ConversationEvent {}

class LoadConversationsEvent extends ConversationEvent {}

class NewConversationEvent extends ConversationEvent {
  final ConversationModel data;
  NewConversationEvent(this.data);
}

class UpdateConversationEvent extends ConversationEvent {
  final ConversationModel data;
  UpdateConversationEvent(this.data);
}

class RemoveConversationEvent extends ConversationEvent {
  final String id;
  RemoveConversationEvent(this.id);
}
