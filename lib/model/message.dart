/// Message object.
class Message {
  /// No set methods as these are all final values
  final String messageId;
  final String senderId;
  final String groupId;
  final String messageContent;

  /// Constructor
  Message({
    required this.messageId,
    required this.senderId,
    required this.groupId,
    required this.messageContent,
  });

  /// Get the message ID.
  String getMessageID() {
    return messageId;
  }

  /// Get the sender ID.
  String getSenderID() {
    return senderId;
  }

  /// Get the group ID.
  String getGroupID() {
    return groupId;
  }

  /// Get the sender ID.
  String getMessageContent() {
    return messageContent;
  }
}
