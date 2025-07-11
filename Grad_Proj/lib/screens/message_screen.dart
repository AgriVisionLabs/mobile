import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/conversation/chat_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/message/message_bloc.dart'
    show MessageBloc;
import 'package:grd_proj/bloc/chat_bloc/message/message_event.dart';
import 'package:grd_proj/bloc/chat_bloc/message/message_state.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/message_model.dart';
import 'package:grd_proj/screens/chat_details.dart';
import 'package:grd_proj/screens/widget/avatar_color.dart';
import 'package:grd_proj/service/signalR/signar_service_message.dart';
import 'package:intl/intl.dart';

class ChatDetailScreen extends StatefulWidget {
  final String conversationId;
  final String name;
  final bool groupe;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.groupe,
    required this.conversationId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

String formatDateHeader(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final messageDate = DateTime(date.year, date.month, date.day);

  if (messageDate == today) return 'Today';
  if (messageDate == yesterday) return 'Yesterday';
  return DateFormat('dd MMM yyyy').format(date);
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  List<MessageModel>? messages;
  ConversationBloc? _conversationBloc;
  final TextEditingController _controller = TextEditingController();

  void startConnection() async {
    final signalRM =
        MessageSignalRService(jwtToken: CacheHelper.getData(key: "token"));

    await signalRM.init(widget.conversationId);
  }

  @override
  void initState() {
    super.initState();
    startConnection();
    context.read<MessageBloc>().add(LoadMessagesEvent(widget.conversationId));
    _conversationBloc = context.read<ConversationBloc>();
  }

  @override
  void dispose() {
    _conversationBloc!.add(LoadConversationsEvent());
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      context.read<MessageBloc>().add(SendMessageEvent(
            conversationId: widget.conversationId,
            content: text,
          ));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          title: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: borderColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        getColorFromLetter(widget.name[0]), // لون حسب الحرف
                    child: Text(
                      widget.name[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  widget.groupe
                      ? GestureDetector(
                          onTap: () {
                            _conversationBloc!.add(ViewConv(
                                conversationId: widget.conversationId));

                            MaterialPageRoute(
                              builder: (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: context.read<ConversationBloc>(),
                                  ),
                                  BlocProvider.value(
                                    value: context.read<MessageBloc>(),
                                  ),
                                ],
                                child: ChatDetails(),
                              ),
                            );
                          },
                          child: Image.asset(
                              "assets/images/mage_dots.png"), // زر الثلاث نقاط
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/Whatsapp.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: .8,
                            color: borderColor,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocConsumer<MessageBloc, MessageState>(
                          listener: (context, state) {
                        if (state is MessageLoaded) {
                          messages = state.messages;
                        }
                      }, builder: (context, state) {
                        if (state is MessageError) {
                          return Center(child: Text(state.error));
                        }
                        if (messages != null) {
                          return ListView(
                            reverse: true,
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
                            children: _buildGroupedMessages(messages!),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ),
                    Positioned(
                        bottom: 0, left: 0, right: 0, child: buildInputArea()),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildInputArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 33, 17, 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(
                    color: Color(0xff616161),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Monrope'),
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: borderColor, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: borderColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: borderColor, width: 1),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: _send,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: primaryColor,
              child: Image.asset(
                'assets/images/send.png',
                height: 28,
                width: 28,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageBubble extends StatefulWidget {
  final String message;
  final bool isMe;
  final String time;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool _showTime = false;

  void _toggleTimeVisibility() {
    setState(() {
      _showTime = !_showTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleTimeVisibility,
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: widget.isMe ? primaryColor : const Color(0xffE9E9E9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              widget.message,
              style: TextStyle(
                color: widget.isMe ? Colors.white : Colors.black,
                fontSize: 15,
                fontFamily: 'monrope',
              ),
            ),
          ),
          if (_showTime)
            Padding(
              padding: EdgeInsets.only(
                left: widget.isMe ? 0 : 8,
                right: widget.isMe ? 8 : 0,
              ),
              child: Text(
                DateFormat('hh:mm a').format(DateTime.parse(widget.time)),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontFamily: 'monrope',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

List<Widget> _buildGroupedMessages(List<MessageModel> messages) {
  Map<String, List<MessageModel>> grouped = {};

  for (var message in messages.reversed) {
    final dateKey = formatDateHeader(message.sentAt);
    grouped.putIfAbsent(dateKey, () => []).add(message);
  }

  List<Widget> widgets = [];

  grouped.forEach((date, msgs) {
    widgets.add(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              date,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );

    for (var msg in msgs) {
      final isMe = msg.senderId == CacheHelper.getData(key: "id");
      widgets.add(
        MessageBubble(
          message: msg.content,
          isMe: isMe,
          time: msg.sentAt.toString(),
        ),
      );
    }
  });

  return widgets.reversed
      .toList(); // مهم علشان تبقى الرسائل بالترتيب من تحت لفوق
}
