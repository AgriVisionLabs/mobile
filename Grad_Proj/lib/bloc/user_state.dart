
class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {}

final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String errMessage;
  final dynamic errors;
  
  SignInFailure({required this.errMessage,required this.errors});
}


final class SignUpSuccess extends UserState {}

final class SignUpLoading extends UserState {}

final class SignUpFailure extends UserState {
  final String errMessage;
  final dynamic errors;
  
  SignUpFailure({required this.errMessage,required this.errors});
}

final class ConfirmEmailSuccess extends UserState {}

final class ConfirmEmailLoading extends UserState {}

final class ConfirmEmailFailure extends UserState {
  final String errMessage;
  ConfirmEmailFailure({required this.errMessage});
}

final class ConfirmEmailResand extends UserState {}

final class RefreshTokenSuccess extends UserState {}

final class RefreshTokenLoading extends UserState {}

final class RefreshTokenFailure extends UserState {
  final String errMessage;
  final dynamic errors;
  
  RefreshTokenFailure({required this.errMessage,required this.errors});
}

final class ForgetPasswordSuccess extends UserState {}
final class ForgetPasswordFailure extends UserState {
  final String errMessage;
  final dynamic errors;
  
  ForgetPasswordFailure({required this.errMessage,required this.errors});
}

final class OTPSuccess extends UserState {}

final class OTPFailure extends UserState {
  final String errMessage;
  final dynamic errors;
  
  OTPFailure({required this.errMessage,required this.errors});
}

final class ResetPasswordSuccess extends UserState {}

final class ResetPasswordFailure extends UserState {
  final String errMessage;
  final dynamic errors;
  
  ResetPasswordFailure({required this.errMessage,required this.errors});
}


