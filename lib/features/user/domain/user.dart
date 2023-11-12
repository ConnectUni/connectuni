/// The User object.

class User {
  final String uid;
  final String email;
  String displayName;
  String pfp;
  String major;
  String projectedGraduation;
  String status;
  List<User> friends;
  List<String> groupIDs;
  List<String> eventIDs;
  List<String> interests;
  String password;

  /// Constructor
  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.pfp,
    required this.major,
    required this.projectedGraduation,
    required this.status,
    required this.friends,
    required this.groupIDs,
    required this.eventIDs,
    required this.interests,
    required this.password,
  });

  /// Change name.
  void setUserName(String newName) {
    displayName = newName;
  }

  /// Change profile picture.
  void setPhotoURL(String newPfp) {
    pfp = newPfp;
  }

  /// Change major.
  void setMajor(String newMajor) {
    major = newMajor;
  }

  /// Change projected graduation.
  void setGradDate(String newGradDate) {
    projectedGraduation = newGradDate;
  }

  /// Change status.
  void setStatus(String newStatus) {
    status = newStatus;
  }

  /// Add User to friends list.
  void addFriend(User newFriend) {
    friends.add(newFriend);
  }

  /// Delete User from friends list.
  void deleteFriend(User deleteFriend) {
    friends.remove(deleteFriend);
  }

  /// Add a new group ID.
  void addGroupID(String newGroupID) {
    groupIDs.add(newGroupID);
  }

  /// Delete a group ID.
  void deleteGroupID(String deleteGroupID) {
    groupIDs.remove(deleteGroupID);
  }

  /// Add a new event ID.
  void addEventID(String newEventID) {
    eventIDs.add(newEventID);
  }

  /// Delete a event ID.
  void deleteEventID(String deleteEventID) {
    eventIDs.remove(deleteEventID);
  }

  /// Add a new interest.
  void addInterest(String newInterest) {
    interests.add(newInterest);
  }

  ///Delete a interest.
  void deleteInterest(String deleteInterest) {
    interests.remove(deleteInterest);
  }

  String getUid() {
    return uid;
  }

  String getEmail() {
    return email;
  }

  String getName() {
    return displayName;
  }

  String getPfp() {
    return pfp;
  }

  String getMajor() {
    return major;
  }

  String getGradDate() {
    return projectedGraduation;
  }

  String getStatus() {
    return status;
  }

  List<User> getFriends() {
    return friends;
  }

  List<String> getGroupIDs() {
    return groupIDs;
  }

  List<String> getEventIDs() {
    return eventIDs;
  }

  String getPassword() {
    return password;
  }
}
