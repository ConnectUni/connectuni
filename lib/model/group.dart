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
  String chatID;
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

  String getChatID() {
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

  /// Get all users - maybe we can move this code to where it's actually being rendered?
  List<User> getAllUsersInGroup() {
    return userIDs.map((userId) => usersDB.getUserByID(userId)).toList();
  }

  /// Add an event ID to the group
  void addEventId(String eventId) {
    eventIDs.add(eventId);
  }

  /// Remove an event ID from the group
  void removeEventId(String eventId) {
    eventIDs.remove(eventId);
  }

  /// Add a user ID to the group
  void addUserId(String userId) {
    if (!userIDs.contains(userId)) {
      userIDs.add(userId);
    }
  }

  /// Remove a user ID from the group
  void removeUserId(String userId) {
    if (userIDs.contains(userId)) {
      userIDs.remove(userId);
    }
  }

  /// Set the list of new messages
  void setNewMessages(List<Message> newMessages) {
    this.newMessages = newMessages;
  }

  /// Set the group image
  void setGroupImage(String groupImage) {
    this.groupImage = groupImage;
  }

  /// Set the group description
  void setGroupDescription(String newDesc) {
    groupDescription = newDesc;
  }

  /// Add an interest
  void addInterest(String interest) {
    interests.add(interest);
  }

  /// Remove an interest
  void removeInterest(String interest) {
    if (interests.contains(interest)) {
      interests.remove(interest);
    }
  }
}
