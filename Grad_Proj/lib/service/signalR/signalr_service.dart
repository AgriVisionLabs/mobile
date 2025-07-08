// ignore_for_file: avoid_print

import 'package:signalr_netcore/http_connection_options.dart';
import 'dart:convert';

import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ConversationSignalRService {
  final String hubUrl = "https://api.agrivisionlabs.tech/hubs/conversations";
  final String jwtToken;
  final String userId;

  HubConnection? _connection;

  /// Callback functions to trigger Bloc events
  void Function(Map<String, dynamic>)? onNewConversation;
  void Function(Map<String, dynamic>)? onConversationUpdated;
  void Function(String)? onConversationRemoved;

  ConversationSignalRService({
    required this.jwtToken,
    required this.userId,
  });

  Future<void> init() async {
    _connection = HubConnectionBuilder()
        .withUrl(
          hubUrl,
          options: HttpConnectionOptions(
            accessTokenFactory: () async => jwtToken,
          ),
        )
        .withAutomaticReconnect()
        .build();

    /// Bind SignalR methods to local handlers
    _connection!.on("NewConversation", _handleNewConversation);
    _connection!.on("ConversationUpdated", _handleConversationUpdated);
    _connection!.on("ConversationRemoved", _handleConversationRemoved);

    try {
      await _connection!.start();
      print("✅ Connected to ConversationHub");

      await _connection!.invoke("SubscribeToConversationUpdates", args: []);
      print("🧩 Subscribed to private group: user-$userId");
    } catch (e) {
      print("❌ Failed to connect: $e");
    }
  }

  void _handleNewConversation(dynamic args) {
    if (args != null && onNewConversation != null) {
      final data = Map<String, dynamic>.from(jsonDecode(jsonEncode(args)));
      onNewConversation!(data);
    }
  }

  void _handleConversationUpdated(dynamic args) async {
    if (args != null && args.isNotEmpty && onConversationUpdated != null) {
      final data = Map<String, dynamic>.from(jsonDecode(jsonEncode(args[0])));
      onConversationUpdated!(data);
    }
  }

  void _handleConversationRemoved(dynamic args) async {
    if (args != null && args.isNotEmpty && onConversationRemoved != null) {
      final id = args[0].toString();
      onConversationRemoved!(id);
    }
  }

  void setListeners({
    void Function(Map<String, dynamic>)? onNew,
    void Function(Map<String, dynamic>)? onUpdate,
    void Function(String)? onRemove,
  }) {
    onNewConversation = onNew;
    onConversationUpdated = onUpdate;
    onConversationRemoved = onRemove;
  }

  Future<void> stop() async {
    await _connection?.stop();
    print("⛔ SignalR connection stopped");
  }
}
