import 'chat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The ChatList object.
class ChatList {
  List<Chat> chatList;

  /// Constructor
  ChatList(this.chatList);

  /// Returns single Chat object, search with its chatID
  Chat getChat(String chatID) {
    return chatList.firstWhere((chat) => chat.chatID == chatID);
  }

  /// Returns list of chat IDs - may use for displaying direct messages
  List<String> getChatIDs() {
    return chatList.map((data) => data.chatID).toList();
  }
}

/// DELETE THIS BOTTOM SECTION AFTER GETTING REAL DB
final List<Chat> mockChats = [
  Chat(
    chatID: 'chat-001',
    groupID: 'group-001',
    userIDs: ['user-001', 'user-002', 'user-003'],
    messageIDs: ['message-001', 'message-002', 'message-003'],
  ),
  Chat(
      chatID: 'chat-002',
      groupID: 'group-002',
      userIDs: ['user-004', 'user-001'],
      messageIDs: ['message-004', 'message-006']),
  Chat(
      chatID: 'chat-003',
      groupID: 'group-005',
      userIDs: ['user-003', 'user-004', 'user-005'],
      messageIDs: ['message-013', 'message-014', 'message-015'])
];

final chatDBProvider = Provider<ChatList>((ref) { return ChatList(mockChats); });