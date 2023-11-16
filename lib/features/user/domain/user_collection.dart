import 'user.dart';

/// Encapsulates operations on the list of [User] returned from Firestore.
class UserCollection {
  UserCollection(users) : _users = users;

  final List<User> _users;

  User getUser(String userID) {
    return _users.firstWhere((data) => data.uid == userID);
  }

  List<User> getUsers(List<String> userIDs) {
    return _users.where((data) => userIDs.contains(data.uid)).toList();
  }

  int size() {
    return _users.length;
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

  List<String> getAllUserIDs() {
    return _users.map((data) => data.uid).toList();
  }

  List<String> getEmails() {
    return _users.map((data) => data.email).toList();
  }

  List<String> getUsernames() {
    return _users.map((data) => data.displayName).toList();
  }

  List<User> getFriends(String userID) {
    return getUser(userID).friends.toList();
  }

  List<String> getUsersGroupIDs(String userID) {
    return getUser(userID).groupIDs.toList();
  }

  List<String> getUsersEventIDs(String userID) {
    return getUser(userID).eventIDs.toList();
  }

  List<String> getUsersInterests(String userID) {
    return getUser(userID).interests.toList();
  }
}
