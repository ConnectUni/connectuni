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

  List<Message> getUsersMessages(String userID) {
    return _messages.where((message) => message.senderId == userID).toList();
  }

  List<String> getAllMessageIDs() {
    return _messages.map((message) => message.messageId).toList();
  }

  String getSenderID(String messageID) {
    return getMessage(messageID).senderId;
  }

  String getContentFrom(String messageID) {
    return getMessage(messageID).messageContent;
  }

  int size() {
    return _messages.length;
  }

  String getNewID() {
    String result = '';
    int newIDNum = size();

    do {
      if (newIDNum < 9) {
        result = 'message-00${newIDNum + 1}';
      } else if (newIDNum < 99) {
        result = 'message-0${newIDNum + 1}';
      } else {
        result = 'message-${newIDNum + 1}';
      }

      newIDNum++;
    } while (getAllMessageIDs().contains(result));

    return result;
  }
}
