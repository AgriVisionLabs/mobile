import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/chat_bloc/conversation/chat_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/message_container.dart';
import 'package:grd_proj/screens/widget/avatar_color.dart';
import 'package:grd_proj/screens/widget/circule_indector.dart';
import 'package:grd_proj/screens/widget/conversation_function.dart';
import 'package:grd_proj/screens/widget/text.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    context.read<ConversationBloc>().add(LoadConversationsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final List<String> userNames = [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            const SizedBox(height: 60),
            _buildSearchBar(),
            Expanded(
              child: BlocConsumer<ConversationBloc, ConversationState>(
                listener: (context, state) {
                  if (state is ConversationAddSuccess) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Conversation Created Successfuly"),
                        ),
                      );
                    });
                    context
                        .read<ConversationBloc>()
                        .add(LoadConversationsEvent());
                  } else if (state is ConversationAddFailure) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    });
                    context
                        .read<ConversationBloc>()
                        .add(LoadConversationsEvent());

                    context
                        .read<ConversationBloc>()
                        .formKey
                        .currentState!
                        .validate();
                  }
                  if (state is ConversationDeleteSuccess) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Conversation Deleted Successfuly"),
                        ),
                      );
                    });
                    context
                        .read<ConversationBloc>()
                        .add(LoadConversationsEvent());
                  } else if (state is ConversationAddFailure) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    });
                    context
                        .read<ConversationBloc>()
                        .add(LoadConversationsEvent());
                  }
                },
                builder: (context, state) {
                  if (state is ConversationLoading) {
                    return circularProgressIndicator();
                  } else if (state is ConversationLoaded) {
                    final chats = state.conversations;
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];

                        return Dismissible(
                            direction: DismissDirection.horizontal,
                            onDismissed: (_) {
                              context.read<ConversationBloc>().add(
                                    DeleteConversationEvent(
                                        conversationId: chat.id),
                                  );
                            },
                            key: UniqueKey(),
                            background: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.delete,
                                  color: borderColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                text(fontSize: 18, label: "Delete Conversation")
                              ],
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value:
                                              context.read<ConversationBloc>(),
                                        ),
                                        
                                      ],
                                      child: MessageContainer(
                                        name: chat.name,
                                        groupe: chat.isGroup,
                                        convId: chat.id,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: getColorFromLetter(
                                    chat.name[0]), // لون حسب الحرف
                                child: Text(
                                  chat.name[0].toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              title: Text(chat.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              subtitle: Text(
                                chat.lastMessage?.content ?? "No messages yet",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                chat.lastMessage != null
                                    ? formatMessageTime(
                                        chat.lastMessage!.sentAt)
                                    : '',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ));
                      },
                    );
                  } else if (state is ConversationError) {
                    return Center(child: Text(state.message));
                  } else if (state is ConversationEmpty) {
                    return const Center(child: Text("No conversations"));
                  }
                  return const Center(child: Text("Loading..."));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Icon(Icons.arrow_back_ios,
                            color: textColor2, size: 20)),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("ِNew Conversation",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "manrope",
                          color: primaryColor,
                        )),
                  ],
                ),
                backgroundColor: Colors.white,
                content: SizedBox(
                  width: 380,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Add Members",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                            color: borderColor,
                          )),
                      const SizedBox(height: 5),
                      Form(
                        key: context.read<ConversationBloc>().formKey,
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: controller,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 17),
                            hintText: "Email or Username",
                            hintStyle: const TextStyle(color: borderColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                  color: borderColor, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                  color: primaryColor, width: 2.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                  color: errorColor, width: 2.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                  color: errorColor, width: 2.0),
                            ),
                          ),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            final trimmed = value.trim();
                            if (trimmed.isNotEmpty &&
                                !userNames.contains(trimmed)) {
                              setState(() {
                                userNames.add(trimmed);
                                controller.clear();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Container(
                    width: 380,
                    height: 50,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(25)),
                    child: GestureDetector(
                      onTap: () {
                        context.read<ConversationBloc>().memberEmails =
                            userNames;
                        context.read<ConversationBloc>().add(
                              CreateConversationEvent(),
                            );
                      },
                      child: const Center(
                        child: Text("Start Conversation",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "manrope",
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          backgroundColor: primaryColor,
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
            color: grayColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Monrope',
          ),
          prefixIcon:
              const Icon(Icons.search, color: Color(0xff9F9F9F), size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }
}
