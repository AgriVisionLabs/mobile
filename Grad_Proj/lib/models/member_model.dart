class FarmMemberModel {
  final String memberId;
  final String farmId;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final int roleId;
  final String roleName;
  final DateTime joinedAt;
  final String invitedByUserName;
  final String invitedById;
  final bool isOwner;

  FarmMemberModel({
    required this.memberId,
    required this.farmId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.roleId,
    required this.roleName,
    required this.joinedAt,
    required this.invitedByUserName,
    required this.invitedById,
    required this.isOwner,
  });

  factory FarmMemberModel.fromJson(Map<String, dynamic> json) {
    return FarmMemberModel(
      memberId: json['memberId'],
      farmId: json['farmId'],
      userName: json['userName'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      roleId: json['roleId'],
      roleName: json['roleName'],
      joinedAt: DateTime.parse(json['joinedAt']),
      invitedByUserName: json['invitedByUserName'],
      invitedById: json['invitedById'],
      isOwner: json['isOwner'],
    );
  }

}