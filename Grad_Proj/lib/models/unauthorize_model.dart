// ignore_for_file: public_member_api_docs, sort_constructors_first
//error type in response
class UnAuthorizeModel {
  List ? email;
  List ? password;
  List ? firstName;
  List ? lasttName;
  List ? userName;
  List ? phoneNumber;
  List ? otp;

  UnAuthorizeModel({
    this.email,
    this.password,
    this.firstName,
    this.lasttName,
    this.userName,
    this.phoneNumber,
    this.otp
  });

  factory UnAuthorizeModel.fromJson(Map<dynamic, dynamic> jsonData) {
    return UnAuthorizeModel(
        email: jsonData["Email"],
        password: jsonData["Password"],
        firstName: jsonData["FirstName"],
        lasttName: jsonData["LastName"],
        userName: jsonData["UserName"],
        phoneNumber: jsonData["PhoneNumber"],
        otp : jsonData["Otp"]
        );
  }

}


