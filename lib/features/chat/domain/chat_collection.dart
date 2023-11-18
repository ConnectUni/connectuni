import '../../message/domain/message.dart';
import '../../message/domain/message_collection.dart';
import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';
import 'chat.dart';

/// Encapsulates operations on the list of [Chat] returned from Firestore.
class ChatCollection {
  ChatCollection(chats) : _chats = chats;

  final List<Chat> _chats;

  Chat getChat(String chatID) {
    return _chats.firstWhere((data) => data.chatID == chatID);
  }

  List<Chat> getChats(List<String> chatIDs) {
    return _chats.where((data) => chatIDs.contains(data.chatID)).toList();
  }

  int size() {
    return _chats.length;
  }

  String getNewID() {
    String result = '';
    switch (size()) {
      case < 10:
        result = 'chat-00${size() + 1}';
        break;
      case < 100:
        result = 'chat-0${size() + 1}';
        break;
      default:
        result = 'chat-${size() + 1}';
    }
    return result;
  }

  List<String> getAllChatIDs() {
    return _chats.map((data) => data.chatID).toList();
  }

  String getGroupID(String chatID) {
    return getChat(chatID).groupID;
  }

  List<User> getUsersInChats(UserCollection users, String chatID) {
    return users.getUsers(getUserIDsInChat(chatID));
  }

  List<String> getUserIDsInChat(String chatID) {
    return getChat(chatID).userIDs.toList();
  }

  List<String> getMessageIDsInChat(String chatID) {
    return getChat(chatID).messageIDs.toList();
  }

  List<Message> getMessagesInChat(MessageCollection messages, String chatID) {
    return messages.getMessages(getMessageIDsInChat(chatID));
  }

}
