import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/bloc/chat_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/bloc/chat_state.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('💬 Conversations'),
            actions: [
              if (!state.isConnected)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.cloud_off, color: Colors.red),
                ),
            ],
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.selectedConversationId == null
                  ? _buildConversationList(context, state)
                  : _buildMessagesView(context, state),
        );
      },
    );
  }

  Widget _buildConversationList(BuildContext context, ChatState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: state.conversations.length,
      itemBuilder: (context, index) {
        final conv = state.conversations[index];
        return Card(
          child: ListTile(
            title: Text('Conversation ${conv['id']}'),
            subtitle: Text(conv['name'] ?? 'No name'),
            onTap: () {
              context.read<ChatBloc>().add(
                    SelectConversationEvent(conv['id']),
                  );
            },
          ),
        );
      },
    );
  }

  Widget _buildMessagesView(BuildContext context, ChatState state) {
    final TextEditingController controller = TextEditingController();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(12),
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final msg = state.messages.reversed.toList()[index];
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(msg['content'] ?? ''),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: 'Type a message'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final message = {
                    'conversationId': state.selectedConversationId,
                    'senderId': context.read<ChatBloc>().userId,
                    'content': controller.text,
                    'timestamp': DateTime.now().toIso8601String(),
                  };
                  context.read<ChatBloc>().add(SendMessageEvent(message));
                  controller.clear();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
} 
