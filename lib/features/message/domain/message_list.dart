import 'message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageList {
  List<Message> allMessages;

  MessageList({required this.allMessages});

  Message getMessage(String messageId) {
    return allMessages.firstWhere((message) => message.messageId == messageId);
  }

  Iterable<Message> getGroupMessages(String groupId) {
    return allMessages.where((message) => message.groupId == groupId);
  }

  List<Message> getMessages() {
    return allMessages;
  }
}

/// Provides access to and operations on all defined messages.
final List<Message> mockMessages = [
  Message(
    messageId: 'message-001',
    senderId: 'user-001',
    groupId: 'group-001',
    messageContent:
        'guys i think we should have everyone review and approve our prs before merging to main',
  ),
  Message(
    messageId: 'message-002',
    senderId: 'user-002',
    groupId: 'group-001',
    messageContent: 'i agree, that way we all know whats going on in the code',
  ),
  Message(
    messageId: 'message-003',
    senderId: 'user-003',
    groupId: 'group-001',
    messageContent: 'im down with that',
  ),
  Message(
    messageId: 'message-004',
    senderId: 'user-004',
    groupId: 'group-002',
    messageContent: 'do you have any idea how to do assignemnt 3?',
  ),
  Message(
    messageId: 'message-005',
    senderId: 'user-005',
    groupId: 'group-002',
    messageContent: 'yeah what do you need help with?',
  ),
  Message(
    messageId: 'message-006',
    senderId: 'user-001',
    groupId: 'group-002',
    messageContent: 'i need help too, i have no idea what im doing',
  ),
  Message(
    messageId: 'message-007',
    senderId: 'user-002',
    groupId: 'group-003',
    messageContent: 'im having trouble understanding assembly can anyone help?',
  ),
  Message(
    messageId: 'message-008',
    senderId: 'user-003',
    groupId: 'group-003',
    messageContent: 'sure! do you want to meet up in the library?',
  ),
  Message(
    messageId: 'message-009',
    senderId: 'user-004',
    groupId: 'group-003',
    messageContent: 'can i come too?',
  ),
  Message(
    messageId: 'message-010',
    senderId: 'user-005',
    groupId: 'group-004',
    messageContent: 'guys i think i failed the exam today',
  ),
  Message(
    messageId: 'message-011',
    senderId: 'user-001',
    groupId: 'group-004',
    messageContent: 'its okay i think we all failed',
  ),
  Message(
    messageId: 'message-012',
    senderId: 'user-002',
    groupId: 'group-004',
    messageContent: 'lets get a study group goin',
  ),
  Message(
    messageId: 'message-013',
    senderId: 'user-003',
    groupId: 'group-005',
    messageContent: 'Man these techtalks are so boring',
  ),
  Message(
    messageId: 'message-014',
    senderId: 'user-004',
    groupId: 'group-005',
    messageContent: 'its okay at least theres free food',
  ),
  Message(
    messageId: 'message-015',
    senderId: 'user-005',
    groupId: 'group-005',
    messageContent: 'i think i find this stuff interesting',
  ),
];

final messagesDBProvider = Provider<MessageList>((ref) { return MessageList(allMessages: mockMessages); });
