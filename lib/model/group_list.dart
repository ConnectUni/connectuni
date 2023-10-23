// import 'package:js/js_util.dart';
// import 'package:./js_util/js_util.dart';

import 'package:connectuni/model/message.dart';

import 'group.dart';

/// The GroupList object.
class GroupList {
  List<Group> allGroups;

  /// Constructor
  GroupList(this.allGroups);

  /// Return list of Group objects
  List<Group> getAllGroups() {
    return allGroups;
  }

  /// Return single Group object, search with their group ID
  Group getGroupById(String groupId) {
    return allGroups.firstWhere((group) => group.groupID == groupId);
  }

  /// Return single Group object, search with their group name
  Group getGroupByName(String groupName) {
    return allGroups.firstWhere((group) => group.groupName == groupName);
  }

  /// Return single Group object, search with their semester year
  Group getGroupBySemYear(String semYear) {
    return allGroups.firstWhere((group) => group.semYear == semYear);
  }

  /// Return single Group object, search with their owner
  Group getGroupByProfessor(String owner) {
    return allGroups.firstWhere((group) => group.owner == owner);
  }

  /// Return list of Group objects that a user is in, search with their user ID
  List<Group> getGroupsByUser(String userId) {
    return allGroups.where((group) => group.userIDs.contains(userId)).toList();
  }

  /// Add a group
  void addGroup(Group group) {
    allGroups.add(group);
  }

  /// Remove a group
  void removeGroup(Group group) {
    if (allGroups.contains(group)) {
      allGroups.remove(group);
    }
  }
}

/// DELETE THIS BOTTOM SECTION AFTER GETTING REAL DB
final List<Group> allGroups = [
  Group(
    groupID: 'group-001',
    groupName: 'ICS 466',
    semYear: 'Fall 2023',
    owner: 'Philip Johnson',
    groupImage: 'group-001.png',
    groupDescription: "This is a group for ICS 466.",
    newMessages: [
      Message(
          messageId: 'message-001',
          senderId: 'user-002',
          groupId: 'group-001',
          messageContent: 'wassap'),
      Message(
          messageId: 'message-002',
          senderId: 'user-001',
          groupId: 'group-001',
          messageContent: 'not much')
    ],
    chatID: 'chat-001',
    eventIDs: ['event-001'],
    userIDs: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
    interests: ['Computer Science'],
  ),
  Group(
    groupID: 'group-002',
    groupName: 'ICS 332',
    semYear: 'Fall 2023',
    groupImage: 'group-002.png',
    owner: 'Henri Casanova',
    groupDescription: "This is a group for ICS 332.",
    newMessages: [
      Message(
          messageId: 'message-003',
          senderId: 'user-003',
          groupId: 'group-002',
          messageContent: 'how was the test?'),
      Message(
          messageId: 'message-004',
          senderId: 'user-001',
          groupId: 'group-002',
          messageContent: 'bad')
    ],
    chatID: 'chat-002',
    eventIDs: [],
    userIDs: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
    interests: ['Computer Science'],
  ),
  Group(
    groupID: 'group-003',
    groupName: 'ICS 312',
    semYear: 'Fall 2023',
    groupImage: 'group-003.png',
    owner: 'Kim Binsted',
    groupDescription: "This is a group for ICS 312.",
    newMessages: [
      Message(
          messageId: 'message-005',
          senderId: 'user-003',
          groupId: 'group-003',
          messageContent: 'why is the sky blue btw?'),
      Message(
          messageId: 'message-006',
          senderId: 'user-001',
          groupId: 'group-003',
          messageContent: 'thats a really good question')
    ],
    chatID: 'chat-003',
    eventIDs: [],
    userIDs: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
    interests: ['Computer Science'],
  ),
  Group(
    groupID: 'group-004',
    groupName: 'Math 307',
    semYear: 'Fall 2023',
    groupImage: 'group-004.png',
    owner: 'Julian Hachmeister',
    groupDescription: "This is a group for Math 307.",
    newMessages: [
      Message(
          messageId: 'message-007',
          senderId: 'user-005',
          groupId: 'group-004',
          messageContent: 'i need help'),
      Message(
          messageId: 'message-008',
          senderId: 'user-002',
          groupId: 'group-004',
          messageContent: 'me too')
    ],
    chatID: 'chat-004',
    eventIDs: ['event-003', 'event-004'],
    userIDs: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
    interests: ['Mathematics'],
  ),
  Group(
    groupID: 'group-005',
    groupName: 'ICS 496',
    semYear: 'Fall 2023',
    groupImage: 'group-005.png',
    owner: 'Anthony Peruma',
    groupDescription: "This is a group for ICS 496.",
    newMessages: [
      Message(
          messageId: 'message-007',
          senderId: 'user-005',
          groupId: 'group-008',
          messageContent: 'so when u add two ones you actually get three'),
      Message(
          messageId: 'message-008',
          senderId: 'user-004',
          groupId: 'group-008',
          messageContent: 'idgi')
    ],
    chatID: 'chat-005',
    eventIDs: ['event-005'],
    userIDs: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
    interests: ['Computer Science'],
  ),
];

GroupList groupsDB = GroupList(allGroups);