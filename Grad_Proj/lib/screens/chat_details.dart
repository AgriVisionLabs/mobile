import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/conversation/chat_bloc.dart';
import 'package:grd_proj/screens/widget/text.dart';

class ChatDetails extends StatefulWidget {
  const ChatDetails({super.key});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ConversationBloc, ConversationState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SafeArea(
              child: Container(
            child: Column(
              children: [text(fontSize: 22, label: "Group Members")],
            ),
          ));
        },
      ),
    );
  }
}
