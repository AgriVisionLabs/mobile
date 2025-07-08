import 'package:grd_proj/bloc/chat_bloc/bloc/chat_bloc.dart';
import 'package:grd_proj/models/conversation_model.dart';
import 'package:grd_proj/service/api/api_consumer.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/service/signalR/signalr_service.dart';

class ConversationRepository {
  final ApiConsumer api;
  final ConversationSignalRService signalR; // ✅ أضفناها
  ConversationRepository(this.api, this.signalR);

  // API: GET all conversations
  Future<List<ConversationModel>> fetchConversations() async {
    final response = await api.get(EndPoints.conversations);

    final raw = response
        .map<ConversationModel>((json) => ConversationModel.fromJson(json))
        .toList();
    return raw;
  }

  // API: POST create new conversation
  Future<ConversationModel> createConversation({
    required List<String> memberIds,
    String? name,
  }) async {
    final response = await api.post(
      EndPoints.conversations,
      data: {
        "name": name,
        "membersList": memberIds,
      },
    );

    final raw = ConversationModel.fromJson(response);
    return raw;
  }

  // ✅ NEW: Bind SignalR listeners to BLoC
  void setBlocListeners(ConversationBloc bloc) {
    signalR.setListeners(
      onNew: (data) =>
          bloc.add(NewConversationEvent(data as ConversationModel)),
      onUpdate: (data) =>
          bloc.add(UpdateConversationEvent(data as ConversationModel)),
      onRemove: (id) => bloc.add(RemoveConversationEvent(id)),
    );
  }
}
