part of 'account_bloc.dart';

abstract class AccountState{}


class AccountInitial extends AccountState {}
class ViewAccountDetailsSuccess extends AccountState {
  final UserModel user;

   ViewAccountDetailsSuccess({required this.user});
 
}

class ViewAccountDetailsFailure extends AccountState {
  final String errMessage;
  final dynamic errors;
   ViewAccountDetailsFailure({
    required this.errMessage,
    required this.errors,
  });

}

class EditAccountDetailsSuccess extends AccountState {}

class EditAccountDetailsFailure extends AccountState {
  final String errMessage;
  final dynamic errors;
   EditAccountDetailsFailure({
    required this.errMessage,
    required this.errors,
  });

}

class ChangePasswordSuccess extends AccountState {}

class ChangePasswordFailure extends AccountState {
  final String errMessage;
  final dynamic errors;
   ChangePasswordFailure({
    required this.errMessage,
    required this.errors,
  });

}

class VerifySuccess extends AccountState {}

class VerifyFailure extends AccountState {
  final String errMessage;
  final dynamic errors;
   VerifyFailure({
    required this.errMessage,
    required this.errors,
  });

}

class PaymentSuccess extends AccountState {}

class PaymentFailure extends AccountState {
  final String errMessage;
  final dynamic errors;
   PaymentFailure({
    required this.errMessage,
    required this.errors,
  });

}