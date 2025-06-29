// sensor_event.dart
part of 'sensor_bloc.dart';

abstract class SensorEvent extends Equatable {
  const SensorEvent();

  @override
  List<Object> get props => [];
}

class ConnectToHub extends SensorEvent {
  final String token ;
  final String farmId ; 
  const ConnectToHub({required this.token,required this.farmId });
}

class DisconnectFromHub extends SensorEvent {
  final String error;
  const DisconnectFromHub({required this.error});

  @override
  List<Object> get props => [error];
}

class NewSensorDataReceived extends SensorEvent {
  final String unitId;
  final String data;
  const NewSensorDataReceived({required this.unitId, required this.data});

  @override
  List<Object> get props => [unitId, data];
}