part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class StartConnectionEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String user;
  final String message;
  SendMessageEvent(this.user, this.message);
}

class MessageReceivedEvent extends ChatEvent {
  final String user;
  final String message;
  MessageReceivedEvent(this.user, this.message);
}
