import 'chat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The ChatList object.
class ChatList {
  List<Chat> chatList;

  /// Constructor
  ChatList(this.chatList);

  /// Returns single Chat object, search with its chatID
  Chat getChatByChatId(String chatID) {
    return chatList.firstWhere((chat) => chat.chatID == chatID);
  }

  /// Returns single Chat object, search with its chatID
  Chat getChatByGroupId(String groupID) {
    return chatList.firstWhere((chat) => chat.groupID == groupID);
  }

  /// Returns list of chat IDs - may use for displaying direct messages
  List<String> getChatIDs() {
    return chatList.map((data) => data.chatID).toList();
  }

  int chatLength() {
    return chatList.length;
  }
  void addChat(Chat chat) {
    chatList.add(chat);
  }

  void addMessageIdToGroupChat(String groupId, String messageId) {
    Chat chat = getChatByGroupId(groupId);
    chat.messageIDs.add(messageId);
  }
}

/// DELETE THIS BOTTOM SECTION AFTER GETTING REAL DB
final List<Chat> mockChats = [
  Chat(
    chatID: "chat-001",
    groupID: "group-001",
    userIDs: [],
    messageIDs: [],
  ),
  Chat(
    chatID: "chat-002",
    groupID: "group-002",
    userIDs: [],
    messageIDs: [],
  ),
  Chat(
    chatID: "chat-003",
    groupID: "group-003",
    userIDs: [],
    messageIDs: [],
  ),
  Chat(
    chatID: "chat-004",
    groupID: "group-004",
    userIDs: [],
    messageIDs: [],
  ),
  Chat(
    chatID: "chat-005",
    groupID: "group-005",
    userIDs: [],
    messageIDs: [],
  ),
  ];