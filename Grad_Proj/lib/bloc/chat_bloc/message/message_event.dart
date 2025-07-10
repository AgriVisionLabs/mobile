import 'package:grd_proj/models/message_model.dart';

abstract class MessageEvent {}

class LoadMessagesEvent extends MessageEvent {
  final String conversationId;
  LoadMessagesEvent(this.conversationId);
}

class SendMessageEvent extends MessageEvent {
  final String conversationId;
  final String content;
  SendMessageEvent({
    required this.conversationId,
    required this.content,
  });
}

class ReceiveMessageEvent extends MessageEvent {
  final MessageModel message;
  ReceiveMessageEvent(this.message);
}
