// ignore_for_file: use_rethrow_when_possible, avoid_print, unused_local_variable

import 'package:grd_proj/bloc/chat_bloc/conversation/chat_bloc.dart';
import 'package:grd_proj/models/conversation_model.dart';
import 'package:grd_proj/models/message_model.dart';
import 'package:grd_proj/service/api/api_consumer.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/service/errors/exception.dart';
import 'package:grd_proj/service/signalR/signalr_service.dart';

class ConversationRepository {
  final ApiConsumer api;
  final ConversationSignalRService signalR; // ✅ أضفناها
  ConversationRepository(this.api, this.signalR);

  // API: GET all conversations
  // Future<List<ConversationModel>> fetchConversations() async {
  //   try {
  //     final response = await api.get(EndPoints.conversations);
  //     return (response as List)
  //         .map((e) => ConversationModel.fromJson(e))
  //         .toList();
  //   } on ServerException catch (e) {
  //     print("ServerException: ${e.errorModel.message}");

  //     rethrow;
  //   } catch (e) {
  //     // لأي خطأ تاني غير ServerException
  //     throw Exception("Failed to create conversation");
  //   }
  // }

  // API: POST create new conversation
  Future<ConversationModel> createConversation({
    required List<String> memberIds,
    String? name,
  }) async {
    try {
      final response = await api.post(
        EndPoints.conversations,
        data: {
          "name": name,
          "membersList": memberIds,
        },
      );

      return ConversationModel.fromJson(response);
    } on ServerException catch (e) {
      print("ServerException: ${e.errorModel.message}");
      rethrow;
    } catch (e) {
      print("Unknown error in createConversation: $e");
      throw Exception("Failed to create conversation");
    }
  }

  Future<void> deleteConversationEvent({
    required String convId,
  }) async {
    try {
      final response = await api.delete(
        "${EndPoints.conversations}/$convId",
      );
    } on ServerException catch (e) {
      print("ServerException: ${e.errorModel.message}");
      rethrow;
    } catch (e) {
      print("Unknown error in createConversation: $e");
      throw Exception("Failed to create conversation");
    }
  }

  Future<void> viewConv({
    required String convId,
  }) async {
    try {
      final response = await api.get(
        "${EndPoints.conversations}/$convId",
      );
    } on ServerException catch (e) {
      print("ServerException: ${e.errorModel.message}");
      rethrow;
    } catch (e) {
      print("Unknown error in createConversation: $e");
      throw Exception("Failed to create conversation");
    }
  }

  Future<List<ConversationModel>> fetchConversations() async {
    try {
      final response = await api.get(EndPoints.conversations);
      final conversations =
          (response as List).map((e) => ConversationModel.fromJson(e)).toList();

      for (final conv in conversations) {
        try {
          final messagesResponse = await api
              .get('${EndPoints.conversations}/${conv.id}/Messages'); // تأكدي من endpoint هنا

          final messages =
              messagesResponse.map<MessageModel>((json) => MessageModel.fromJson(json))
              .toList();

          if (messages.isNotEmpty) {
            conv.lastMessage = messages.first;
          }
        } catch (e) {
          print('❌ Failed to fetch messages for ${conv.id}: $e');
        }
      }

      return conversations;
    } on ServerException catch (e) {
      print("ServerException: ${e.errorModel.message}");
      rethrow;
    } catch (e) {
      throw Exception("Failed to fetch conversations");
    }
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
