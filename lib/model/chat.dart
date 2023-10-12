import 'dart:core';

class ChatData {
  ChatData({
    required this.chatId,
    required this.groupId,
    required this.userId,
    required this.messageId});

  String chatId;
  String groupId;
  List<String> userId;
  List<String> messageId;
}

class ChatDB {
  final List<ChatData> chats = [
    ChatData(
      chatId: 'chat-001',
      groupId: 'group-001',
      userId: ['user-001', 'user-002', 'user-003'],
      messageId: ['message-001', 'message-002', 'message-003'],
    ),
    ChatData(
        chatId: 'chat-002',
        groupId: 'group-002',
        userId: ['user-004','user-001'],
        messageId: ['message-004', 'message-006']
    ),
    ChatData(
      chatId: 'chat-003',
      groupId: 'group-005',
      userId: ['user-003', 'user-004', 'user-005'],
      messageId: ['message-013', 'message-014', 'message-015']
    )
  ];

  ChatData getChat(String chatId) {
    return chats.firstWhere((chat) => chat.chatId == chatId);
  }

  List<String> getChatIds() {
    return chats.map((data) => data.chatId).toList();
  }

  ChatDB chatDB = ChatDB();
}