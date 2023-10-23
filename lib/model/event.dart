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
