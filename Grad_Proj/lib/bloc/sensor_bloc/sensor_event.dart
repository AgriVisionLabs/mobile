// sensor_event.dart
part of 'sensor_bloc.dart';

abstract class SensorEvent {}

class ConnectToHub extends SensorEvent {
  final String token;
  final String farmId;
  ConnectToHub({required this.token, required this.farmId});
}

class DisconnectFromHub extends SensorEvent {
  final String error;
  DisconnectFromHub({required this.error});
}

class NewSensorDataReceived extends SensorEvent {
  final String unitId;
  final String data;
  NewSensorDataReceived({required this.unitId, required this.data});
}

class UpdateSensorFromSignalREvent extends SensorEvent {
  final SensorDevice updatedDevice;

  UpdateSensorFromSignalREvent({required this.updatedDevice});
}
