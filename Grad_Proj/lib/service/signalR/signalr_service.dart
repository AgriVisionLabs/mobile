import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/itransport.dart';


class ChatSignalRService {
  late final HubConnection _connection;

  ChatSignalRService({required String baseUrl, required String token}) {
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
    await _connection.start();
  }

  void sendMessage(String user, String message) {
    _connection.invoke('SendMessage', args: [user, message]);
  }

  void onMessageReceived(Function(String user, String message) callback) {
    _connection.on('ReceiveMessage', (args) {
      final user = args?[0] as String;
      final message = args?[1] as String;
      callback(user, message);
    });
  }

  Future<void> stopConnection() async {
    await _connection.stop();
  }
}
