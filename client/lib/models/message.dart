import 'dart:convert';

class IncomingMessage {
  final String content;
  final int conversationId;
  final int senderId;

  IncomingMessage({
    required this.content,
    required this.conversationId,
    required this.senderId,
  });

  factory IncomingMessage.fromJson(Map<String, dynamic> json) {
    final messageContent = json['content'] as String;
    final messageConversationid = json['conversation_id'] as int;
    final messageSenderid = json['sender_id'] as int;

    try {
      return IncomingMessage(
        content: messageContent,
        conversationId: messageConversationid,
        senderId: messageSenderid,
      );
    } catch (e) {
      print('Error deserializing IncomingMessage: $e');
      rethrow;
    }
  }
}

class Message {
  final String content;
  final int senderId;

  Message({
    required this.content,
    required this.senderId,
  });

  String toJson() {
    return jsonEncode({
      'content': content,
      'sender_id': senderId,
    });
  }
}
