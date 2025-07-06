part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// اتصال SignalR
class StartConnectionEvent extends ChatEvent {}

// تحميل المحادثات
class LoadConversationsEvent extends ChatEvent {}

// اختيار محادثة معينة
class SelectConversationEvent extends ChatEvent {
  final String conversationId;

  SelectConversationEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

// إرسال رسالة
class SendMessageEvent extends ChatEvent {
  final Map<String, dynamic> message;

  SendMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}

// استلام رسالة
class MessageReceivedEvent extends ChatEvent {
  final Map<String, dynamic> message;

  MessageReceivedEvent(this.message);

  @override
  List<Object?> get props => [message];
}
