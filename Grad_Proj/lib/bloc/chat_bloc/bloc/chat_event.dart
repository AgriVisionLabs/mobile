// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  UpdateConversationEvent(
    this.data
  );
}

class RemoveConversationEvent extends ConversationEvent {
  final String conversationId;
  RemoveConversationEvent(this.conversationId);
}

class CreateConversationEvent extends ConversationEvent {}

class DeleteConversationEvent extends ConversationEvent {
  final String conversationId;
  DeleteConversationEvent({
    required this.conversationId,
  });
}
