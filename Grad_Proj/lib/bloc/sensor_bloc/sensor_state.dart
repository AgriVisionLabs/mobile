part of 'sensor_bloc.dart';

abstract class SensorState {}

class SensorInitial extends SensorState {}

class SensorConnecting extends SensorState {}

class SensorConnected extends SensorState {
  final String farmId;
   SensorConnected({required this.farmId});
}

class SensorDisconnected extends SensorState {
  final String error;
   SensorDisconnected({required this.error});

}

class SensorConnectionError extends SensorState {
  final String error;
   SensorConnectionError({required this.error});

}

class SensorDataReceived extends SensorState {
  final String unitId;
  final String data;
   SensorDataReceived({required this.unitId, required this.data});
}

class SensorDataError extends SensorState {
  final String error;
   SensorDataError({required this.error});
}