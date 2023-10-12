/// A message model that holds the message content and the message id, sender id, group id, and message content.

class Message {
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
