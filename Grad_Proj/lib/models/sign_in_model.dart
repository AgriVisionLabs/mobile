import 'package:grd_proj/core/api/end_points.dart';

class SignInModel {
  final String id;
  final String email;
  final String firstName;
  final String lasttName;
  final String token;
  final int expiresIn;
  final String refreshToken;
  final String refreshTokenExpiration;

  SignInModel({required this.id, required this.email, required this.firstName, required this.lasttName, required this.token, required this.expiresIn, required this.refreshToken, required this.refreshTokenExpiration});

  factory SignInModel.fromJson(Map<String,dynamic> jsonData){
    return SignInModel(
      id: jsonData[ApiKey.id],
      email: jsonData[ApiKey.email],
      firstName: jsonData[ApiKey.firstName],
      lasttName: jsonData[ApiKey.lastName],
      token: jsonData[ApiKey.token],
      expiresIn: jsonData[ApiKey.expiresIn],
      refreshToken: jsonData[ApiKey.refreshToken],
      refreshTokenExpiration: jsonData[ApiKey.refreshTokenExpiration]
    );
  }
}