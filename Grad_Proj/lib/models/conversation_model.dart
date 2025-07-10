import 'package:grd_proj/models/conversation_member.dart';
import 'package:grd_proj/models/message_model.dart';

class ConversationModel {
  final String id;
  final String name;
  final bool isGroup;
  final String? adminId;
  final List<ConversationMember> members;
  MessageModel? lastMessage;
  
  ConversationModel({
    required this.id,
    required this.name,
    required this.isGroup,
    required this.adminId,
    required this.members,
    this.lastMessage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      name: json['name'] ?? '',
      isGroup: json['isGroup'] ?? false,
      adminId: json['adminId'],
      members: (json['membersList'] as List)
          .map((member) => ConversationMember.fromJson(member))
          .toList(),
    );
  }
}
