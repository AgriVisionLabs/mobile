// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'farm_bloc.dart';

@immutable
abstract class FarmEvent {}

class OpenFarmEvent extends FarmEvent{}

class CreateFarmEvent extends FarmEvent{}

class DeleteFarmEvent extends FarmEvent {
  final String farmId;
  DeleteFarmEvent({
    required this.farmId,
  });
}

class EditFarmEvent extends FarmEvent{}

class AddMember extends FarmEvent{}

class DeleteMember extends FarmEvent{
  final int invitationNum;

  DeleteMember({required this.invitationNum});
}

class ViewFarmDetails extends FarmEvent{
  final String farmId;
  ViewFarmDetails({required this.farmId});
}

class ViewFarmMembers extends FarmEvent{}


class RolePermissions extends FarmEvent{}