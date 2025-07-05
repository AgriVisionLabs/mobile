import 'package:bloc/bloc.dart';
import 'package:grd_proj/service/signalR/signalr_service.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatSignalRService signalRService;
  List<Map<String, String>> _messages = [];

  ChatBloc(this.signalRService) : super(ChatInitial()) {
    on<StartConnectionEvent>((event, emit) async {
      await signalRService.startConnection();
      signalRService.onMessageReceived((user, message) {
        add(MessageReceivedEvent(user, message));
      });
      emit(ChatConnected());
    });

    on<SendMessageEvent>((event, emit) {
      signalRService.sendMessage(event.user, event.message);
    });

    on<MessageReceivedEvent>((event, emit) {
      _messages.add({'user': event.user, 'message': event.message});
      emit(ChatMessageReceived(List.from(_messages)));
    });
  }
}
