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

class EditPasswordSuccess extends AccountState {
  final UserModel user;

   EditPasswordSuccess({required this.user});
 
}

class EditPasswordFailure extends AccountState {
  final String errMessage;
  final dynamic errors;
   EditPasswordFailure({
    required this.errMessage,
    required this.errors,
  });

}