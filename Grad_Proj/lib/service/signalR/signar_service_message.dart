// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:signalr_netcore/signalr_client.dart';

class MessageSignalRService {
  final String jwtToken;
  final String hubUrl = "https://api.agrivisionlabs.tech/hubs/messages";
  HubConnection? _connection;

  /// Callback
  void Function(Map<String, dynamic>)? onMessageReceived;

  MessageSignalRService({required this.jwtToken});

  Future<void> init(String conversationId) async {
    _connection = HubConnectionBuilder()
        .withUrl(hubUrl, options: HttpConnectionOptions(
          accessTokenFactory: () async => jwtToken,
        ))
        .withAutomaticReconnect()
        .build();

    _connection!.on('ReceiveMessage', (args) {
      if (args != null && args.isNotEmpty && onMessageReceived != null) {
        final msg = Map<String, dynamic>.from(jsonDecode(jsonEncode(args[0])));
        onMessageReceived!(msg);
      }
    });

    try {
      await _connection!.start();
      print('SignalR connected (Messages)');
      await _connection!.invoke('SubscribeToConversations', args: [conversationId]);
    } catch (e) {
      print('SignalR connection error: $e');
    }
  }

  void setListeners({
    void Function(Map<String, dynamic>)? onMessage,
  }) {
    onMessageReceived = onMessage;
  }

  Future<void> stop() async {
    await _connection?.stop();
    print('⛔ SignalR disconnected');
  }
}
