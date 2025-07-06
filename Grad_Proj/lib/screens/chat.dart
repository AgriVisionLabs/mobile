// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChatListScreen(),
  ));
}

class ChatListScreen extends StatefulWidget {

  ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'John Doe',
      'message': 'John Typing now ...',
      'time': '1h',
      'color': primaryColor,
      'unread': 1,
    },
    {
      'name': 'Mark',
      'message': "I'm doing great, thanks for as...",
      'time': '2h',
      'color': Colors.orange,
      'unread': 0,
    },
    {
      'name': 'Ali',
      'message': "I'm doing great, thanks for as...",
      'time': '3h',
      'color': Colors.blue,
      'unread': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.infinity,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search conversations...',
                  hintStyle: TextStyle(color: Color(0xff616161), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Monrope'),
                  prefixIcon: Icon(Icons.search, color: Color(0xff9F9F9F), size: 20),
                  filled: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: borderColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: borderColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailScreen(name: chat['name'], color: chat['color']),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: chat['color'],
                    child: Text(chat['name'][0], style: TextStyle(color: Colors.white)),
                  ),
                  title: Text(chat['name'], style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(chat['message'], maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(chat['time']),
                      if (chat['unread'] > 0)
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: primaryColor,
                          child: Text('${chat['unread']}', style: TextStyle(color: Colors.white, fontSize: 12)),
                        )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primaryColor,
          tooltip: 'New Chat',
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          child: Icon(Icons.add, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

class ChatDetailScreen extends StatelessWidget {
  final String name;
  final Color color;

  ChatDetailScreen({super.key, required this.name, required this.color});

final List<Map<String, dynamic>> messages = [
  {'text': 'Hey there! How are you doing?', 'isMe': false, 'time': '05:45'},
  {'text': "I'm doing great, thanks for asking!\nHow about you?", 'isMe': true, 'time': '05:45'},
];

List<Map<String, dynamic>> get reorderedMessages => [messages[1], messages[0]];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  'assets/images/back.png',
                  height: 20,
                  width: 20,
                  color: Color(0xff8B919B),
                ),
              ),
              SizedBox(width: 12),
              CircleAvatar(
                backgroundColor: color,
                child: Text(name[0], style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 8),
              Text(name, style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:Stack(
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
              
                ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = reorderedMessages[index];
                    final isMe = msg['isMe'];
                    return Column(
                      crossAxisAlignment: msg['isMe'] ? CrossAxisAlignment.end  : CrossAxisAlignment.start,
                      children: [ 
                        Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        padding: EdgeInsets.all(12),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                        decoration: BoxDecoration(
                          color: msg['isMe'] ? primaryColor : Color(0xffE9E9E9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:  Text(
                          msg['text'],
                          style: TextStyle(color: isMe ? Colors.white : Colors.black),
                        ),
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.only(left: isMe ? 0 : 8, right: isMe ? 8 : 0),
                        child: Text(
                          msg['time'],
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 33, 17, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Color(0xff616161), fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Monrope'),
                      filled: false,
                      fillColor: Colors.transparent,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: borderColor, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: borderColor, width: 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                  print('Send message');
                  },
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
          )
        ],
      ),
    );
  }
}
