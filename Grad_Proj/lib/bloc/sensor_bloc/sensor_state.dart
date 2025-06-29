part of 'sensor_bloc.dart';

abstract class SensorState extends Equatable {
  const SensorState();

  @override
  List<Object> get props => [];
}

class SensorInitial extends SensorState {}

class SensorConnecting extends SensorState {}

class SensorConnected extends SensorState {
  final String farmId;
  const SensorConnected({required this.farmId});

  @override
  List<Object> get props => [farmId];
}

class SensorDisconnected extends SensorState {
  final String error;
  const SensorDisconnected({required this.error});

  @override
  List<Object> get props => [error];
}

class SensorConnectionError extends SensorState {
  final String error;
  const SensorConnectionError({required this.error});

  @override
  List<Object> get props => [error];
}

class SensorDataReceived extends SensorState {
  final String unitId;
  final String data;
  const SensorDataReceived({required this.unitId, required this.data});

  @override
  List<Object> get props => [unitId, data];
}