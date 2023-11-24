/// Defines the domain model path strings for [FirestoreService].
class FirestorePath {
  static String user(String userID) => 'users/$userID';
  static String users() => 'users';

  static String group(String groupID) => 'groups/$groupID';
  static String groups() => 'groups';

  static String event(String eventID) => 'events/$eventID';
  static String events() => 'events';

  static String chat(String chatID) => 'chats/$chatID';
  static String chats() => 'chats';

  static String message(String messageId) => 'messages/$messageId';
  static String messages() => 'messages';

  static String notification(String notificationId) => 'notifications/$notificationId';
  static String notifications() => 'notifications';
}
