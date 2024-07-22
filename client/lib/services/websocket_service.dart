import 'dart:async';
import 'dart:convert';

import 'package:client/models/message.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class InitialConnectionParams {
  String senderId;
  String receiverId;
  String conversationId;

  InitialConnectionParams({
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
  });

  String toJson() {
    return jsonEncode({
      'sender_id': senderId,
      'receiver_id': receiverId,
      'conversation_id': conversationId,
    });
  }
}

class InitialResponse {
  final String type;
  final int conversationId;

  InitialResponse({required this.type, required this.conversationId});

  factory InitialResponse.fromJson(Map<String, dynamic> json) {
    try {
      // Ensure the 'type' field exists and is a String
      if (json.containsKey('type') && json['type'] is String) {
        final String type = json['type'];

        // Check if 'conversation_id' exists and is a String
        final int conversationId = json.containsKey('conversation_id') &&
                json['conversation_id'] is int
            ? json['conversation_id']
            : 12;

        return InitialResponse(
          type: type,
          conversationId: conversationId,
        );
      } else {
        throw Exception("Invalid or missing 'type' field");
      }
    } catch (e) {
      print('Error deserializing InitialResponse: $e');
      rethrow;
    }
  }
}

class WebSocketService extends ChangeNotifier {
  WebSocketChannel? _channel;
  final StreamController<IncomingMessage> _streamController =
      StreamController<IncomingMessage>();

  bool _initialMessageReceived = false;
  int? _conversationId;
  final List<Message> _messages = [];

  int? get conversationId => _conversationId;
  List<Message> get messages => _messages;
  Stream<IncomingMessage> get stream => _streamController.stream;

  void connect(String url, InitialConnectionParams params) {
    final uri = Uri.parse(url).replace(queryParameters: {
      'sender_id': params.senderId,
      'receiver_id': params.receiverId,
      // 'conversation_id': params.conversationId,
      'conversation_id': "12",
    });
    _channel = WebSocketChannel.connect(uri);

    _channel!.stream.listen((message) {
      _handleMessage(message);
      notifyListeners();
    }, onError: (error) {
      ErrorWidget(error);
    }, onDone: () {
      _streamController.close();
    });
  }

  void _handleMessage(String message) {
    final parsedMessage = jsonDecode(message);
    final IncomingMessage incomingMessage;

    if (!_initialMessageReceived) {
      InitialResponse initialResponse = InitialResponse.fromJson(parsedMessage);
      _conversationId = initialResponse.conversationId;
      _initialMessageReceived = true;
      incomingMessage = IncomingMessage(
        content: 'Initial message received',
        conversationId: initialResponse.conversationId,
        senderId: 0,
      );
    } else {
      incomingMessage = IncomingMessage.fromJson(parsedMessage);
    }
    _streamController.add(incomingMessage);
    notifyListeners();
  }

  void send(String message) {
    _channel!.sink.add(message);
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
}
