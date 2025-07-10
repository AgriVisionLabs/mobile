import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/message_repositry.dart';
import 'package:grd_proj/models/message_model.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository repository;
  List<MessageModel> _messages = [];

  MessageBloc(this.repository) : super(MessageInitial()) {
    on<LoadMessagesEvent>((event, emit) async {
      emit(MessageLoading());
      try {
        final messages = await repository.fetchMessages(event.conversationId);
        _messages = messages;
        emit(MessageLoaded(_messages));
      } catch (e) {
        emit(MessageError('Failed to load messages'));
      }
    });
    on<SendMessageEvent>((event, emit) async {
      emit(MessageSending());
      try {
        final message = await repository.sendMessage(
          conversationId: event.conversationId,
          content: event.content,
        );
        _messages.insert(0, message);
        emit(MessageLoaded(List.from(_messages))); // لإعادة تحميل القائمة
      } catch (e) {
        emit(MessageError('Failed to send message'));
      }
    });

    on<ReceiveMessageEvent>((event, emit) {
      _messages.add(event.message);
      emit(MessageLoaded(List.from(_messages)));
    });
  }
}
