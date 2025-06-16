part of 'farm_bloc.dart';

@immutable
abstract class FarmState {}

class FarmInitial extends FarmState {
   final List starlist;
  FarmInitial(this.starlist);
}
class FarmLoaded extends FarmState{}

class FarmSuccess extends FarmState{}

class FarmInfoSuccess extends FarmState{}


final class FarmFailure extends FarmState {
  final String errMessage;
  final dynamic errors;
  
  FarmFailure({required this.errMessage,required this.errors});
}

final class FarmInfoFailure extends FarmState {
  final String errMessage;
  final dynamic errors;
  
  FarmInfoFailure({required this.errMessage,required this.errors});
}