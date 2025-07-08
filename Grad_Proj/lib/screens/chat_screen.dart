
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/bloc/chat_bloc.dart';
import 'package:grd_proj/components/color.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 60),
          _buildSearchBar(),
          Expanded(
            child: BlocBuilder<ConversationBloc, ConversationState>(
              builder: (context, state) {
                if (state is ConversationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ConversationLoaded) {
                  final chats = state.conversations;
                  if (chats.isEmpty) return const Center(child: Text("No conversations"));

                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return ListTile(
                        onTap: () {
                         
                        },
                        leading: CircleAvatar(
                          backgroundColor: primaryColor,
                          child: Text(
                            chat.name[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(chat.name,
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('Members: ${chat.members.length }'),
                        trailing: const Text("🕐"),
                      );
                    },
                  );
                } else if (state is ConversationError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text("Loading..."));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            // open create conversation screen (we'll build it بعدين)
          },
          backgroundColor: primaryColor,
          tooltip: 'New Chat',
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search conversations...',
          hintStyle: const TextStyle(
            color: Color(0xff616161),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Monrope',
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xff9F9F9F), size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }
}
