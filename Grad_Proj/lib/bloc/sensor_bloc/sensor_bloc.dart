// sensor_bloc.dart
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:grd_proj/models/sensor_model.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import 'package:equatable/equatable.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  late final HubConnection _connection;
  SensorBloc() : super(SensorInitial()) {
    on<ConnectToHub>((event, emit) async {
      if (_connection.state == HubConnectionState.Connected) return;

      emit(SensorConnecting());

      _connection = HubConnectionBuilder()
          .withUrl('https://agrivision.tryasp.net/hubs/sensors',
              options: HttpConnectionOptions(
                accessTokenFactory: () async => event.token,
              ))
          .withAutomaticReconnect()
          .build();

      _connection.onclose(({Exception? error}) {
        add(DisconnectFromHub(error: error?.toString() ?? 'Connection closed'));
      });

      _connection.on('ReceiveReading', (args) {
        if (args!.length >= 2) {
          final unitId = args[0].toString();
          final data = args[1];
          final prettyData = const JsonEncoder.withIndent('  ').convert(data);
          add(NewSensorDataReceived(
              unitId: unitId.toString(), data: prettyData));
        }
      });

      try {
        await _connection.start();
        await _connection
            .invoke("SubscribeToFarm", args: [event.farmId.toString()]);
        emit(SensorConnected(farmId: event.farmId.toString()));
      } catch (e) {
        emit(SensorConnectionError(error: e.toString()));
      }
    });

    on<DisconnectFromHub>((event, emit) async {
      emit(SensorDisconnected(error: event.error));
    });

    on<NewSensorDataReceived>((event, emit) async {
      emit(SensorDataReceived(unitId: event.unitId, data: event.data));
    });
  }
  @override
  Future<void> close() {
    _connection.stop();
    return super.close();
  }
}
