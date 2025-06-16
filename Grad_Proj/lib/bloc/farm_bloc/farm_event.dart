part of 'farm_bloc.dart';

@immutable
abstract class FarmEvent {}

class CreateFarmEvent extends FarmEvent{}

class DeleteFarmEvent extends FarmEvent{}

class EditFarmEvent extends FarmEvent{}

class AddMember extends FarmEvent{}

class DeleteMember extends FarmEvent{}