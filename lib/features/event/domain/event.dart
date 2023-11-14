/***
/// The Event object.
class SingleEvent {
  final String eventID;
  final String eventName;
  final String eventLocation;
  final DateTime eventDate;
  final String groupID;
  String eventIcon;
  String eventDescription;
  List<String> userIDs;
  List<String> interests;

  /// Constructor
  SingleEvent({
    required this.eventID,
    required this.eventName,
    required this.eventIcon,
    required this.eventLocation,
    required this.eventDescription,
    required this.eventDate, //Ex. DateTime(2023, 10, 13, 12, 30)
    required this.groupID,
    required this.userIDs,
    required this.interests,
  });

  /// Set a new Event icon
  void setEventIcon(String newIcon) {
    eventIcon = newIcon;
  }

  /// Set a new Event description
  void setDescription(String newDesc) {
    eventDescription = newDesc;
  }

  /// Add a user to the Event, search with their userID
  void addUser(String userID) {
    userIDs.add(userID);
  }

  /// Remove a user from the Event, search with their userID
  void removeUser(String userID) {
    if (userIDs.contains(userID)) {
      userIDs.remove(userID);
    }
  }

  /// Check if a user is in the Event, search with their userID
  bool isUserInEvent(String userID) {
    return userIDs.contains(userID);
  }
}
*/
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@Freezed()
class SingleEvent with _$SingleEvent {
  const SingleEvent._();
  const factory SingleEvent({
    required final String eventID,
    required final String eventName,
    required final String eventLocation,
    required final DateTime eventDate,
    required final String groupID,
    required String eventIcon,
    required String eventDescription,
    required List<String> userIDs,
    required List<String> interests,
}) = _SingleEvent;
  
  /// Add a user to the Event, search with their userID
  void addUser(String userID) {
    userIDs.add(userID);
  }

  /// Remove a user from the Event, search with their userID
  void removeUser(String userID) {
    if (userIDs.contains(userID)) {
      userIDs.remove(userID);
    }
  }

  /// Check if a user is in the Event, search with their userID
  bool isUserInEvent(String userID) {
    return userIDs.contains(userID);
  }
  factory SingleEvent.fromJson(Map<String, dynamic> json) => _$SingleEventFromJson(json);
}