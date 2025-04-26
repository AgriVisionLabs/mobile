class EndPoints {
  static const String baseUrl = 'https://agrivision.tryasp.net/';
  static const String login = 'Auth';
  static const String register = 'Auth/register';
  static const String confirmEmailResand = '/Auth/resend-confirmation-email';
  static const String forgetPassword = '/Auth/forget-password';
  static const String otp = '/Auth/verify-otp';
  static const String resetPassword= '/Auth/reset-password';
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
}