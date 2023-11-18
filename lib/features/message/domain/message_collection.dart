import 'message.dart';

/// Encapsulates operations on the list of [Message] returned from Firestore.
class MessageCollection {
  MessageCollection(messages) : _messages = messages;

  final List<Message> _messages;

  Message getMessage(String messageID) {
    return _messages.firstWhere((message) => message.messageId == messageID);
  }

  List<Message> getMessages(List<String> messageIDs) {
    return _messages.where((message) => messageIDs.contains(message.messageId)).toList();
  }

  List<String> getAllMessageIDs() {
    return _messages.map((message) => message.messageId).toList();
  }

  String getSenderID(String messageID) {
    return getMessage(messageID).senderId;
  }

  int size() {
    return _messages.length;
  }

  String getNewID() {
    String result = '';
    switch (size()) {
      case < 10:
        result = 'user-00${size() + 1}';
        break;
      case < 100:
        result = 'user-0${size() + 1}';
        break;
      default:
        result = 'user-${size() + 1}';
    }
    return result;
  }
}
