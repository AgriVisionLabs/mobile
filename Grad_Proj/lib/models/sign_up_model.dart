// ignore_for_file: public_member_api_docs, sort_constructors_first

class SignUpModel {
  List ? email;
  List ? password;
  List ? firstName;
  List ? lasttName;
  List ? userName;
  List ? phoneNumber;

  SignUpModel({
    this.email,
    this.password,
    this.firstName,
    this.lasttName,
    this.userName,
    this.phoneNumber,
  });

  factory SignUpModel.fromJson(Map<dynamic, dynamic> jsonData) {
    return SignUpModel(
        email: jsonData["Email"],
        password: jsonData["Password"],
        firstName: jsonData["FirstName"],
        lasttName: jsonData["LastName"],
        userName: jsonData["UserName"],
        phoneNumber: jsonData["PhoneNumber"],
        );
  }

}


