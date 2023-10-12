import 'package:connectuni/model/message.dart';

import 'user.dart';
import 'user_list.dart';

/// The Group object.
class Group {
  final String groupID;
  final String groupName;
  final String semYear;
  final String owner;
  String groupImage;
  String groupDescription;
  List<Message>
      newMessages; //may need to implement for displaying how many new messages each gc has
  List<String> chatID;
  List<String> eventIDs;
  List<String> userIDs;
  List<String> interests;

  /// Constructor
  Group({
    required this.groupID,
    required this.groupName,
    required this.semYear,
    required this.owner,
    required this.groupImage,
    required this.groupDescription,
    required this.newMessages,
    required this.chatID,
    required this.eventIDs,
    required this.userIDs,
    required this.interests,
  });

  String getGroupID() {
    return groupID;
  }

  String getGroupName() {
    return groupName;
  }

  String getSemYear() {
    return semYear;
  }

  String getOwner() {
    return owner;
  }

  String getGroupImage() {
    return groupImage;
  }

  String getGroupDescription() {
    return groupDescription;
  }

  List<Message> getNewMessages() {
    return newMessages;
  }

  List<String> getChatID() {
    return chatID;
  }

  List<String> getEventID() {
    return eventIDs;
  }

  List<String> getUserIDs() {
    return userIDs;
  }

  List<String> getInterests() {
    return interests;
  }

  /// Add a chat ID to the group.
  void addChatId(String chatId) {
    chatID.add(chatId);
  }

  //Setter method for removing a chat ID from the group.
  void removeChatId(String chatId) {
    chatID.remove(chatId);
  }

  //Setter method for adding an event ID to the group.
  void addEventId(String eventId) {
    eventIDs.add(eventId);
  }

  //Setter method for removing an event ID from the group.
  void removeEventId(String eventId) {
    eventIDs.remove(eventId);
  }

  //Setter method for adding a user ID to the gsroup.
  void addUserId(String userId) {
    if (!userIDs.contains(userId)) {
      userIDs.add(userId);
    }
  }

  //Setter method for removing a user ID from the group.
  void removeUserId(String userId) {
    if (userIDs.contains(userId)) {
      userIDs.remove(userId);
    }
  }

  //Setter method to update the number of new messages.
  void updateNewMessages(int newMessages) {
    this.newMessages = newMessages;
  }

  //Setter method to update the group image.
  void updateGroupImage(String groupImage) {
    this.groupImage = groupImage;
  }

  //Setter methtod to update the group description.
  void updateGroupDescription(String newDesc) {
    groupDescription = newDesc;
  }

  //Setter method for adding interests.
  void addInterest(String interest) {
    interests.add(interest);
  }

  //Setter method for removing interests.
  void removeInterest(String interest) {
    interests.remove(interest);
  }

  ///Getter methods for list fields.
  //Getter method for grabbing all users in a group.
  List<User> getAllUsersInGroup() {
    return userIDs.map((userId) => usersDB.getUserByID(userId)).toList();
  }
}

///Provides access to and operations on all defined groups.
class GroupsDB {
  final List<Group> allGroups = [
    Group(
      groupID: 'group-001',
      groupName: 'ICS 466',
      semYear: 'Fall 2023',
      owner: 'Philip Johnson',
      groupImage: 'group-001.png',
      groupDescription: "This is a group for ICS 466.",
      newMessages: 3,
      chatID: [],
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
      newMessages: 17,
      chatID: [],
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
      newMessages: 0,
      chatID: [],
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
      newMessages: 10,
      chatID: [],
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
      newMessages: 2,
      chatID: [],
      eventIDs: ['event-005'],
      userIDs: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
      interests: ['Computer Science'],
    ),
  ];

  ///SETTER METHODS:
  void addGroup(Group group) {
    allGroups.add(group);
  }

  void removeGroup(Group group) {
    allGroups.remove(group);
  }

  ///GETTER METHODS:
  //Getter method for grabbing a group by its ID.
  Group getGroupById(String groupId) {
    return allGroups.firstWhere((group) => group.groupID == groupId);
  }

  //Getter method for grabbing a group by its name.
  Group getGroupByName(String groupName) {
    return allGroups.firstWhere((group) => group.groupName == groupName);
  }

  //Getter method for grabbing a group by its semester and year.
  Group getGroupBySemYear(String semYear) {
    return allGroups.firstWhere((group) => group.semYear == semYear);
  }

  //Getter method for grabbing a group by its professor.
  Group getGroupByProfessor(String professor) {
    return allGroups.firstWhere((group) => group.owner == professor);
  }

  //Getter method for grabbing all groups that have a certain user.
  List<Group> getGroupsByUser(String userId) {
    return allGroups.where((group) => group.userIDs.contains(userId)).toList();
  }

  //Getter method for grabbing all groups.
  List<Group> getAllGroups() {
    return allGroups;
  } //loadGroups
} //Groups Repository

GroupsDB groupsDB = GroupsDB();
