
class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {}

final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure({required this.errMessage});
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

