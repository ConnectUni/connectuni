/// The Chat object.
class Chat {
  String chatID;
  String groupID;
  List<String> userIDs;
  List<String> messageIDs;

  /// Constructor
  Chat(
      {required this.chatID,
      required this.groupID,
      required this.userIDs,
      required this.messageIDs});
}
