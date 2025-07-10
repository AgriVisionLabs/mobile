import 'package:grd_proj/bloc/chat_bloc/message/message_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/message/message_event.dart';
import 'package:grd_proj/models/message_model.dart';
import 'package:grd_proj/service/api/api_consumer.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/service/signalR/signar_service_message.dart';

class MessageRepository {
  final ApiConsumer api;
  final MessageSignalRService signalR;
  MessageRepository(this.api, this.signalR);

  Future<List<MessageModel>> fetchMessages(String conversationId) async {
    final response =
        await api.get('${EndPoints.conversations}/$conversationId/Messages');

    return (response as List)
        .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<MessageModel> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final response = await api.post(
      '${EndPoints.conversations}/$conversationId/Messages',
      data: {
        'content': content,
      },
    );

    return MessageModel.fromJson(response);
  }

  void setBlocListeners(MessageBloc bloc) {
    signalR.setListeners(
      onMessage: (data) {
        final msg = MessageModel.fromJson(data);
        bloc.add(ReceiveMessageEvent(msg));
      },
    );
  }

  Future<void> connectToSignalR(String conversationId) async {
    await signalR.init(conversationId);
  }

  Future<void> disconnectSignalR() async {
    await signalR.stop();
  }
}
