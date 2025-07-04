class UserModel {
  final String email;
  final String userName;
  final String firstName;
  final String lastName;
  final String? phoneNumber;

  UserModel({
    required this.email,
    required this.userName,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
    );
  }

}
