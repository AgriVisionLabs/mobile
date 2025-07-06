import 'package:flutter/foundation.dart';

@immutable
class ChatState {
  final bool isConnected;
  final bool isLoading;
  final List<Map<String, dynamic>> conversations;
  final List<Map<String, dynamic>> messages;
  final String? selectedConversationId;

  const ChatState({
    this.isConnected = false,
    this.isLoading = false,
    this.conversations = const [],
    this.messages = const [],
    this.selectedConversationId,
  });

  ChatState copyWith({
    bool? isConnected,
    bool? isLoading,
    List<Map<String, dynamic>>? conversations,
    List<Map<String, dynamic>>? messages,
    String? selectedConversationId,
  }) {
    return ChatState(
      isConnected: isConnected ?? this.isConnected,
      isLoading: isLoading ?? this.isLoading,
      conversations: conversations ?? this.conversations,
      messages: messages ?? this.messages,
      selectedConversationId: selectedConversationId ?? this.selectedConversationId,
    );
  }
}
