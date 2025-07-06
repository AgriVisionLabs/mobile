import 'dart:convert';

import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/itransport.dart';

class SignalRService {
  late final HubConnection _connection;

  SignalRService({
    required String baseUrl,
    required String token,
  }) {
    _connection = HubConnectionBuilder()
        .withUrl(
          "$baseUrl/hubs/messages",
          options: HttpConnectionOptions(
            accessTokenFactory: () async => token,
            transport: HttpTransportType.WebSockets,
          ),
        )
        .withAutomaticReconnect()
        .build();
  }

  Future<void> connect() async {
    if (_connection.state != HubConnectionState.Connected) {
      await _connection.start();
      print("Connected to SignalR");
    }
  }

  void onMessageReceived(Function(Map<String, dynamic>) callback) {
    _connection.on("ReceiveMessage", (args) {
      if (args != null && args.isNotEmpty) {
        final msg = Map<String, dynamic>.from(jsonDecode(jsonEncode(args[0])));
        callback(msg);
      }
    });
  }

  Future<void> sendMessage(Map<String, dynamic> msg) async {
    await _connection.invoke("SendMessage", args: [msg]);
  }

  Future<void> subscribeToConversation(String conversationId) async {
    await _connection.invoke("SubscribeToConversations", args: [conversationId]);
  }

  Future<void> disconnect() async {
    await _connection.stop();
  }
}
