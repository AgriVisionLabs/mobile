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

class EditFarmEvent extends FarmEvent {
  final String farmId;
  EditFarmEvent({
    required this.farmId,
  });
}

class AddMember extends FarmEvent {
  final String farmId;
  AddMember({
    required this.farmId,
  });
}

class DeleteMember extends FarmEvent {
  final String invitationId;
  final String farmId;
  DeleteMember({
    required this.invitationId,
    required this.farmId,
  });
}

class ViewFarmDetails extends FarmEvent{
  final String? farmId;
  ViewFarmDetails({required this.farmId});
}

class ViewFarmMembers extends FarmEvent {
  final String farmId;
  ViewFarmMembers({
    required this.farmId,
  });

}


class RolePermissions extends FarmEvent{}