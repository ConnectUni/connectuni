import 'package:connectuni/features/user/domain/user.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';

import 'group.dart';

/// Encapsulates operations on the list of [Group] returned from Firestore.
class GroupCollection {
  GroupCollection(groups) : _groups = groups;

  final List<Group> _groups;

  Group getGroup(String groupID) {
    return _groups.firstWhere((data) => data.groupID == groupID);
  }

  List<Group> getGroups(List<String> groupIDs) {
    return _groups.where((data) => groupIDs.contains(data.groupID)).toList();
  }

  int size() {
    return _groups.length;
  }

  String getNewID() {
    String result = '';
    switch (size()) {
      case < 10:
        result = 'group-00${size() + 1}';
        break;
      case < 100:
        result = 'group-0${size() + 1}';
        break;
      default:
        result = 'group-${size() + 1}';
    }
    return result;
  }

  List<String> getAllGroupIDs() {
    return _groups.map((data) => data.groupID).toList();
  }

  List<User> getUsersInGroups(UserCollection users, String groupID) {
    return users.getUsers(getUserIDsInGroup(groupID));
  }

  List<String> getUserIDsInGroup(String groupID) {
    return getGroup(groupID).userIDs.toList();
  }

  String getGroupName(String groupID) {
    return getGroup(groupID).groupName;
  }

  String getGroupDesc(String groupID) {
    return getGroup(groupID).groupDescription;
  }

  String getChatID(String groupID) {
    return getGroup(groupID).chatID;
  }

  List<String> getGroupInterests(String groupID) {
    return getGroup(groupID).interests.toList();
  }
}
