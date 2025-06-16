class EndPoints {
  static const String baseUrl = 'https://agrivision.tryasp.net/';
  static const String login = 'Auth';
  static const String register = 'Auth/register';
  static const String confirmEmailResand = '/Auth/resend-confirmation-email';
  static const String refreshToken = '/Auth/refresh' ;
  static const String forgetPassword = '/Auth/forget-password';
  static const String otp = '/Auth/verify-otp';
  static const String resetPassword = '/Auth/reset-password';
  static const String farmsInfo = '/Farms';
  static const String team = '/farms/{farmId}/members/{userId}';
}

class ApiKey{
  static String status = 'status';
  static String id = 'id';
  static String userName = 'userName';
  static String email = 'email';
  static String password = 'password';
  static String confirmPassword = 'confirmPassword';
  static String firstName = 'firstName';
  static String lastName = 'lastName';
  static String phoneNumber = 'PhoneNumber';
  static String token = 'token';
  static String expiresIn = 'expiresIn';
  static String refreshToken = 'refreshToken';
  static String refreshTokenExpiration = 'refreshTokenExpiration';
  static String errorMessage = 'title';
  static String otp = 'Otp';
  static String newPassword = 'newPassword';
  static String farmId = 'farmId';
  static String name = 'name';
  static String area = 'area';
  static String location = 'location';
  static String soilType = 'soilType';
  static String fieldsNo = 'fieldsNo';
  static String roleName = 'roleName';
  static String ownerId = 'ownerId';
  static String isOwner = 'isOwner';
}