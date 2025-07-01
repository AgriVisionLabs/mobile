// sensor_bloc.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:grd_proj/models/sensor_model.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  HubConnection? _connection;
  SensorBloc() : super(SensorInitial()) {
    on<ConnectToHub>((event, emit) async {
      emit(SensorConnecting());

      //build connection
      _connection = HubConnectionBuilder()
          .withUrl('https://agrivision.tryasp.net/hubs/sensors',
              options: HttpConnectionOptions(
                accessTokenFactory: () async => event.token,
              ))
          .withAutomaticReconnect()
          .build();

      //close connection
      _connection!.onclose(({Exception? error}) {
        add(DisconnectFromHub(error: error?.toString() ?? 'Connection closed'));
      });

      //receive data
      _connection!.on('ReceiveReading', (args) {
        if (args!.length >= 2) {
          final unitId = args[0].toString();
          final data = args[1];
          final prettyData = const JsonEncoder.withIndent('  ').convert(data);
          add(NewSensorDataReceived(
              unitId: unitId.toString(), data: prettyData));
          print("ReceiveReading fired: ${args.toString()}");
          print("================Received Data: $prettyData==============");
        }
      });

      _connection!.on('message', (args) {
        print("================Generic message received: ${args?.toString()}================");
      });

      //start connection
      try {
        if (_connection != null) {
          await _connection!.start();
          print("================Connected================");
        }
        
        if (_connection != null) {
          await _connection!
              .invoke("SubscribeToFarm", args: [event.farmId.toString()]);
          print("================Subscribed to farm: ${event.farmId}================");
        }

        emit(SensorConnected(farmId: event.farmId.toString()));
      } catch (e) {
        emit(SensorConnectionError(error: e.toString()));
      }
    });

    on<DisconnectFromHub>((event, emit) async {
      print("================Disconnected================");
      emit(SensorDisconnected(error: event.error));
    });

    on<NewSensorDataReceived>((event, emit) async {
      emit(SensorDataReceived(unitId: event.unitId, data: event.data));
    });
  }
  @override
  Future<void> close() async {
    await _connection?.stop();
    return super.close();
  }
}
