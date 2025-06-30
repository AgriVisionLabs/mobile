part of 'account_bloc.dart';

abstract class AccountEvent {}

class ViewAccountDetails extends AccountEvent{}
class EditAccountDetails extends AccountEvent{}
class EditPassword extends AccountEvent{}
