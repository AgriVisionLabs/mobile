import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/itransport.dart';

class SignalRServices {
  late final HubConnection _connection;

  signalRServices({required String baseUrl, required String token}) {
    _connection = HubConnectionBuilder()
        .withUrl(
          "$baseUrl/chatHub",
          options: HttpConnectionOptions(
            accessTokenFactory: () async => token,
            transport: HttpTransportType.WebSockets,
          ),
        )
        .withAutomaticReconnect()
        .build();
  }

  Future<void> startConnection() async {
    try {
      if (_connection.state != HubConnectionState.Connected) {
        await _connection.start();
        print("============== SignalR Connected ==============");
      }
    } catch (e) {
      print("============== Failed to connect: $e ==============");
    }
  }

  Future<void> stopConnection() async {
    if (_connection.state == HubConnectionState.Connected) {
      await _connection.stop();
    }
  }

  void onMessageReceived(Function(String user, String message) callback) {
    _connection.on('ReceiveMessage', (args) {
      final user = args?[0] as String;
      final message = args?[1] as String;
      callback(user, message);
    });
  }
}
