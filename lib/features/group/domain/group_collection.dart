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

  List<Group> getUsersGroups(String userID) {
    return _groups.where((data) => data.userIDs.contains(userID)).toList();
  }

  int size() {
    return _groups.length;
  }

  String getNewID() {
    String result = '';
    int newIDNum = size();

    do {
      if (newIDNum < 9) {
        result = 'group-00${newIDNum + 1}';
      } else if (newIDNum < 99) {
        result = 'group-0${newIDNum + 1}';
      } else {
        result = 'group-${newIDNum + 1}';
      }

      newIDNum++;
    } while (getAllGroupIDs().contains(result));

    return result;
  }

  List<String> getAllGroupIDs() {
    return _groups.map((data) => data.groupID).toList();
  }

  List<String> getAllGroupNames() {
    return _groups.map((data) => data.groupName).toList();
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
