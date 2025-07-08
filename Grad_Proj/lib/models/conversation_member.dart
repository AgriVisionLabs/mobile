class ConversationMember {
  final String id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final bool isAdmin;

  ConversationMember({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isAdmin,
  });

  factory ConversationMember.fromJson(Map<String, dynamic> json) {
    return ConversationMember(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      isAdmin: json['isAdmin'],
    );
  }
}
