// ignore_for_file: public_member_api_docs, sort_constructors_first
class User{
  final int index;
  final String name;
  User(this.index , this.name);
}

class ChatUsers {
  String name;
  String messageText;
  String time;
  ChatUsers({
    required this.name,
    required this.messageText,
    required this.time,
  });
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({
    required this.messageContent,
    required this.messageType,
  });
}
