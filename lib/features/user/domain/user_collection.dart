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
    int newIDNum = size();

    do {
      if (newIDNum < 9) {
        result = 'user-00${newIDNum + 1}';
      } else if (newIDNum < 99) {
        result = 'user-0${newIDNum + 1}';
      } else {
        result = 'user-${newIDNum + 1}';
      }

      newIDNum++;
    } while (getAllUserIDs().contains(result));

    return result;
  }

  List<String> getAllUserIDs() {
    return _users.map((data) => data.uid).toList();
  }

  List<String> getEmails() {
    return _users.map((data) => data.email).toList();
  }

  User? getUserByEmail(String email) {
    if(getEmails().contains(email)) {
      return _users.firstWhere((data) => data.email == email);
    } else {
      return null;
    }
  }

  List<String> getUsernames() {
    return _users.map((data) => data.displayName).toList();
  }

  List<User> getFriends(User user) {
    return getUsers(user.friends);
  }

  List<User> getAssociatedUser(User user) {
    return _users.where((thisUser) {
      if (thisUser.friends.contains(user.uid)
          || thisUser.sentFriendRequests.contains(user.uid)
          || thisUser.receivedFriendRequests.contains(user.uid)) {
        return true;
      }
      return false;
    }).toList();
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
