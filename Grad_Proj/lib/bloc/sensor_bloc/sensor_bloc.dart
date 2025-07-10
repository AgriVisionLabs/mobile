// sensor_bloc.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:grd_proj/models/sensor_model.dart';
import 'package:grd_proj/service/api/api_consumer.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final ApiConsumer api;
  HubConnection? _connection;
  SensorBloc(this.api) : super(SensorInitial()) {
    on<ConnectToHub>((event, emit) async {
      emit(SensorConnecting());

      //build connection
      _connection = HubConnectionBuilder()
          .withUrl('https://api.agrivisionlabs.tech/hubs/sensors',
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
        print(
            "================Generic message received: ${args?.toString()}================");
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
          print(
              "================Subscribed to farm: ${event.farmId}================");
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
    on<LoadInitialSensorReadings>((event, emit) async {
  emit(SensorLoading());
  try {
    final readings = await _fetchLatestReadingsFromApi(event.farmId);
    emit(SensorInitialReadingsLoaded(readings));
  } catch (e) {
    emit(SensorConnectionError(error: e.toString()));
  }
});
  }
  @override
  Future<void> close() async {
    await _connection?.stop();
    return super.close();
  }

  Future<Map<String, String>> _fetchLatestReadingsFromApi(String farmId) async {
    final response =
        await api.get('/your-endpoint/$farmId'); // غيري حسب API الفعلي
    final List data = response['sensors']; // غيري حسب شكل الـ JSON

    Map<String, String> latestReadings = {};

    for (var item in data) {
      final unitId = item['unitId'];
      final reading =
          const JsonEncoder.withIndent('  ').convert(item['latestReading']);
      latestReadings[unitId] = reading;
    }

    return latestReadings;
  }
}
