import 'message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageList {
  List<Message> allMessages;

  MessageList({required this.allMessages});

  Message getMessageById(String messageId) {
    return allMessages.firstWhere((message) => message.messageId == messageId);
  }

  Iterable<Message> getGroupMessages(String groupId) {
    return allMessages.where((message) => message.groupId == groupId);
  }

  List<Message> getMessages() {
    return allMessages;
  }
  int length() {
    return allMessages.length;
  }
  void addMessage(Message message) {
    allMessages.add(message);
  }
}

/// Provides access to and operations on all defined messages.
final List<Message> mockMessages = [

];
