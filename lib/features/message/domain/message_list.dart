import 'message.dart';

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
final List<Message> allMessages = [
  const Message(
    messageId: 'message-001',
    senderId: 'user-001',
    groupId: 'group-001',
    messageContent: 'Hey guys!',
  ),
  const Message(
    messageId: 'message-002',
    senderId: 'user-001',
    groupId: 'group-001',
    messageContent: 'What are your thoughts on 466 so far?',
  ),
  const Message(
    messageId: 'message-003',
    senderId: 'user-002',
    groupId: 'group-001',
    messageContent: 'Hey Albert! I think its cool.',
  ),
  const Message(
    messageId: 'message-004',
    senderId: 'user-003',
    groupId: 'group-001',
    messageContent: 'Anyone have the answer for question 4?',
  ),
  const Message(
    messageId: 'message-005',
    senderId: 'user-001',
    groupId: 'group-001',
    messageContent: 'Sorry bro I don\'t.',
  ),
  const Message(
    messageId: 'message-006',
    senderId: 'user-004',
    groupId: 'group-002',
    messageContent: 'Yo anyone here?',
  ),
  const Message(
    messageId: 'message-007',
    senderId: 'user-005',
    groupId: 'group-002',
    messageContent: 'i dont want to be',
  ),
  const Message(
    messageId: 'message-008',
    senderId: 'user-002',
    groupId: 'group-003',
    messageContent: 'Hello new group!',
  ),
  const Message(
    messageId: 'message-009',
    senderId: 'user-003',
    groupId: 'group-005',
    messageContent: 'Test test 123',
  ),
  const Message(
    messageId: 'message-010',
    senderId: 'user-001',
    groupId: 'group-005',
    messageContent: 'I got that message!',
  ),

];
