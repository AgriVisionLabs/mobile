
class InvitationModel {
  final String id;
  final String farmId;
  final String senderId;
  final String senderUserName;
  final String receiverEmail;
  final String receiverUserName;
  final bool receiverExists;
  final int roleId;
  final String roleName;
  final DateTime expiresAt;
  final DateTime createdOn;

  InvitationModel({
    required this.id,
    required this.farmId,
    required this.senderId,
    required this.senderUserName,
    required this.receiverEmail,
    required this.receiverUserName,
    required this.receiverExists,
    required this.roleId,
    required this.roleName,
    required this.expiresAt,
    required this.createdOn,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id'],
      farmId: json['farmId'],
      senderId: json['senderId'],
      senderUserName: json['senderUserName'],
      receiverEmail: json['receiverEmail'].toString().trim(),
      receiverUserName: json['receiverUserName'],
      receiverExists: json['receiverExists'],
      roleId: json['roleId'],
      roleName: json['roleName'],
      expiresAt: DateTime.parse(json['expiresAt']),
      createdOn: DateTime.parse(json['createdOn']),
    );
  }
}