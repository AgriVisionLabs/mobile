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
  final String farmName;
  final int area;
  final String location;
  final int soilType;
  EditFarmEvent({
    required this.farmId,
    required this.farmName,
    required this.area,
    required this.location,
    required this.soilType,
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