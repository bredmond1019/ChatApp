import 'dart:convert';

import 'package:client/models/message.dart';
import 'package:client/models/user.dart';
import 'package:client/providers/current_user_provider.dart';
import 'package:client/services/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final User receiver;
  final String? conversationId;

  const ChatScreen({super.key, required this.receiver, this.conversationId});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late InitialConnectionParams initialConnectionParams;
  late WebSocketService webSocketService;
  late CurrentUserProvider userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProvider = Provider.of<CurrentUserProvider>(context, listen: false);
    webSocketService = Provider.of<WebSocketService>(context, listen: false);

    initialConnectionParams = InitialConnectionParams(
      senderId: userProvider.user?.id.toString() ?? '1',
      receiverId: widget.receiver.id.toString(),
      conversationId: widget.conversationId ?? '',
    );

    webSocketService.connect(
      'ws://localhost:3000/ws/',
      initialConnectionParams,
    );
  }

  @override
  void dispose() {
    webSocketService.disconnect();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.receiver.name}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: webSocketService.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final incomingMessage = snapshot.data;
                  final List<Message> messages = webSocketService.messages;

                  if (incomingMessage is IncomingMessage) {
                    Message newMessage = Message(
                      content: incomingMessage.content,
                      senderId: incomingMessage.senderId,
                    );
                    messages.add(newMessage);
                  }

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageItem(messages[index]);
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Message message) {
    final CurrentUserProvider userProvider =
        Provider.of<CurrentUserProvider>(context);
    bool isSentByMe = message.senderId == (userProvider.user?.id ?? 1);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment:
            isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSentByMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message.content,
              style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      final conversationId = webSocketService.conversationId;
      if (conversationId != null) {
        webSocketService.send(jsonEncode({
          'conversation_id': conversationId,
          'content': text,
          'sender_id': userProvider.user?.id ?? 1,
        }));
        _controller.clear();
      } else {
        // Handle case where conversation ID is not yet available
      }
    }
  }

  Map<String, dynamic> parseJson(String json) {
    return jsonDecode(json);
  }
}
