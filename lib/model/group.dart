import 'user.dart';
/**
 * Generic outline of the different groups that will be described by each page.
 *
 * Last updated: 10/9 Added getter and setter methods as well as discussed group fields.
 *
 */

///The data associated with groups.
class Group {
  Group({
    required this.groupID, //Ex. group-001
    required this.groupName, // Ex. ICS 466
    required this.semYear, //Ex. Fall 2023
    required this.professor, //Ex. Philip Johnson
    required this.groupImage, //Ex. 'group-001.png'
    required this.groupDescription, //Ex. 'This is a group for ICS 466'
    required this.newMessages, //Ex. 3 (messages)
    required this.chatIds,   // Ex. [chat-001, chat-002 ... chat-042]
    required this.eventIds, // Ex. [event-001, event-002 ... event-042]
    required this.userIds, //Ex. [user-001, user-002 ... user-042]
  });
  
  final String groupID;
  final String groupName;
  final String semYear;
  final String professor;
  String groupDescription;
  int newMessages;
  List<String> chatIds;
  List<String> eventIds;
  List<String> userIds;
  String groupImage;

  ///SETTER METHODS:
  //Setter method for adding a chat ID to the group.
  void addChatId(String chatId) {
    chatIds.add(chatId);
  }
  //Setter method for removing a chat ID from the group.
  void removeChatId(String chatId) {
    chatIds.remove(chatId);
  }
  //Setter method for adding an event ID to the group.
  void addEventId(String eventId) {
    eventIds.add(eventId);
  }
  //Setter method for removing an event ID from the group.
  void removeEventId(String eventId) {
    eventIds.remove(eventId);
  }
  //Setter method for adding a user ID to the group.
  void addUserId(String userId) {
    userIds.add(userId);
  }
  //Setter method for removing a user ID from the group.
  void removeUserId(String userId) {
    userIds.remove(userId);
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
  ///Getter methods for list fields.
  //Getter method for grabbing all users in a group.
  List<User> getAllUsersInGroup() {
    return userIds.map((userId) => usersDB.getUser(userId)).toList();
  }
}

///Provides access to and operations on all defined groups.
class GroupsDB {
  final List<Group> allGroups = [
      Group(
        groupID: 'group-001',
        groupName: 'ICS 466',
        semYear: 'Fall 2023',
        professor: 'Philip Johnson',
        groupImage: 'group-001.png',
        groupDescription: "This is a group for ICS 466.",
        newMessages: 3,
        chatIds: [],
        eventIds: ['event-001'],
        userIds: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
      ),
      Group(
        groupID: 'group-002',
        groupName: 'ICS 332',
        semYear: 'Fall 2023',
        groupImage: 'group-002.png',
        professor: 'Henri Casanova',
        groupDescription: "This is a group for ICS 332.",
        newMessages: 17,
        chatIds: [],
        eventIds: [],
        userIds: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
      ),
      Group(
        groupID: 'group-003',
        groupName: 'ICS 312',
        semYear: 'Fall 2023',
        groupImage: 'group-003.png',
        professor: 'Kim Binsted',
        groupDescription: "This is a group for ICS 312.",
        newMessages: 0,
        chatIds: [],
        eventIds: [],
        userIds: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
      ),
      Group(
        groupID: 'group-004',
        groupName: 'Math 307',
        semYear: 'Fall 2023',
        groupImage: 'group-004.png',
        professor: 'Julian Hachmeister',
        groupDescription: "This is a group for Math 307.",
        newMessages: 10,
        chatIds: [],
        eventIds: ['event-003', 'event-004'],
        userIds: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
      ),
      Group(
        groupID: 'group-005',
        groupName: 'ICS 496',
        semYear: 'Fall 2023',
        groupImage: 'group-005.png',
        professor: 'Anthony Peruma',
        groupDescription: "This is a group for ICS 496.",
        newMessages: 2,
        chatIds: [],
        eventIds: ['event-005'],
        userIds: ['user-001', 'user-002', 'user-003', 'user-004', 'user-005'],
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
    return allGroups.firstWhere((group) => group.professor == professor);
  }
  //Getter method for grabbing all groups.
  List<Group> getAllGroups() {
    return allGroups;
  }//loadGroups
} //Groups Repository

GroupsDB groupsDB = GroupsDB();
