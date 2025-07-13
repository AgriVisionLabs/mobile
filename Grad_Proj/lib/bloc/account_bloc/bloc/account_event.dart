// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_bloc.dart';

abstract class AccountEvent {}

class ViewAccountDetails extends AccountEvent{}
class EditAccountDetails extends AccountEvent{}
class ChangedPassword extends AccountEvent{}
class VerifyOtp extends AccountEvent{}
class PayForPlan extends AccountEvent{}
class ChoocePaln extends AccountEvent {
  final String Id;
  ChoocePaln({
    required this.Id,
  });
}
