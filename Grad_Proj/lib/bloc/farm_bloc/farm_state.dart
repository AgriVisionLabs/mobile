// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'farm_bloc.dart';

@immutable
abstract class FarmState {}

//New user
class FarmInitial extends FarmState {
  final List startlist;
  FarmInitial(this.startlist);
}

//رجعنا  ليست فعلا وهو كان عنده farm
class FarmsLoaded extends FarmState {
  final List<FarmModel> farms;
  FarmsLoaded({
    required this.farms,
  });
  

}

//معندوش ولا farm
class FarmEmpty extends FarmState {
  final List farmList;
  FarmEmpty(this.farmList);
}

//farm ظهرت
class FarmSuccess extends FarmState {}

// دخلنا data و اتقبلت في basic info
class FarmInfoSuccess extends FarmState {}

//حصل مشكلة و احنا بنعرض ال farms
final class FarmFailure extends FarmState {
  final String errMessage;
  final dynamic errors;

  FarmFailure({required this.errMessage, required this.errors});
}

// دخلنا data متقبلتش في basic info
final class FarmInfoFailure extends FarmState {
  final String errMessage;
  final dynamic errors;

  FarmInfoFailure({required this.errMessage, required this.errors});
}

class DeleteFarmSuccess extends FarmState {}

final class DeleteFarmFailure extends FarmState {
  final String errMessage;
  final dynamic errors;

  DeleteFarmFailure({required this.errMessage, required this.errors});
}
class AddingMember extends FarmState {}

class LoadingMember extends FarmState {}

class DeletingMember extends FarmState {}

final class AddingMemberFailure extends FarmState {
  final String errMessage;
  final dynamic errors;

  AddingMemberFailure({required this.errMessage, required this.errors});
}

final class DeletingMemberFailure extends FarmState {
  final String errMessage;
  final dynamic errors;

  DeletingMemberFailure({required this.errMessage, required this.errors});
}

final class LoadingMemberFailure extends FarmState {
  final String errMessage;
  final dynamic errors;

  LoadingMemberFailure({required this.errMessage, required this.errors});
}
