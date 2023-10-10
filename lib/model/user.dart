/**
 * This file contains the User class and the UsersDB class.
 * Generic outline of the different users that will be described by each page.
 */
class User {
  final String uid;
  final String email;
  String displayName;
  String pfp;
  String major;
  String projectedGraduation;
  String status;
  List<String> images;
  List<int> groupIDs;
  List<int> eventIDs;

  /// constructor
  User(
      this.uid,
      this.email,
      this.displayName,
      this.pfp,
      this.major,
      this.projectedGraduation,
      this.status,
      this.images,
      this.groupIDs,
      this.eventIDs);

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

  /// Add image to profile gallery.
  void addImage(String newImage) {
    images.add(newImage);
  }

  /// Delete image from profile gallery.
  void deleteImage(String deleteImage) {
    images.remove(deleteImage);
  }

  /// Add a new group ID.
  void addGroupID(int newGroupID) {
    groupIDs.add(newGroupID);
  }

  /// Delete a group ID.
  void deleteGroupID(int deleteGroupID) {
    groupIDs.remove(deleteGroupID);
  }

  /// Add a new event ID.
  void addEventID(int newEventID) {
    eventIDs.add(newEventID);
  }

  /// Delete a event ID.
  void deleteEventID(int deleteEventID) {
    eventIDs.remove(deleteEventID);
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

  List<String> getImages() {
    return images;
  }

  List<int> getGroupIDs() {
    return groupIDs;
  }

  List<int> getEventIDs() {
    return eventIDs;
  }

  /**SHOULD BE IN A GROUP CLASS*/

  /// Return single User object, search with their name.
  User getUserByName(String name) {
    return allUsers.firstWhere((user) => user.uid == name);
  }

  /// Return single User object, search with their UH ID number.
  /// related: cannot change uid to be int type - throw errors
  User getUserByID(int id) {
    return allUsers.firstWhere((user) => user.uid == id);
  }

  /// Return single User object, search with their email.
  User getUserByEmail(String email) {
    return allUsers.firstWhere((user) => user.email == email);
  }

  /// Return list of User objects.
  /// should be in a Group object class
  List<User> getUsers() {
    return allUsers;
  }
}

class UsersDB {
  final List<User> allUsers = [
    User(
      uid: '1',
      email: 'braddahal@foo.edu',
      displayName: 'Albert Flores',
      pfp: 'assets/images/albert.png',
      major: 'Computer Science',
      projectedGraduation: 'Spring 2024',
      status: 'Almost Friday!',
      images: [
        'assets/images/Feed1.png',
      ],
      groupIDs: [
        123,
        456,
      ],
      eventIDs: [
        111,
        222,
      ],
    ),
    User(
      uid: '2',
      email: 'bmiller@foo.edu',
      displayName: 'Bella Miller',
      pfp: 'assets/images/bella.png',
      major: 'Liberal Arts',
      projectedGraduation: 'Fall 2025',
      status: 'I need a nap.',
      images: [
        'assets/images/Feed1.png',
      ],
      groupIDs: [
        123,
        456,
      ],
      eventIDs: [
        111,
        222,
      ],
    ),
    User(
      uid: '3',
      email: 'coolcaleb@foo.edu',
      displayName: 'Caleb Smith',
      pfp: 'assets/images/caleb.png',
      major: 'Mathematics',
      projectedGraduation: 'Fall 2023',
      status: 'I love math!',
      images: [
        'assets/images/Feed1.png',
      ],
      groupIDs: [
        123,
        456,
      ],
      eventIDs: [
        111,
        222,
      ],
    ),
    User(
      uid: '4',
      email: 'dbonejones@foo.edu',
      displayName: 'Diana Jones',
      pfp: 'assets/images/diana.png',
      major: 'Graphic Design',
      projectedGraduation: 'Spring 2024',
      status: 'I love art!',
      images: [
        'assets/images/Feed1.png',
      ],
      groupIDs: [
        123,
        456,
      ],
      eventIDs: [
        111,
        222,
      ],
    ),
    User(
      uid: '5',
      email: 'brown@foo.edu',
      displayName: 'Ethan Brown',
      pfp: 'assets/images/ethan.png',
      major: 'Business',
      projectedGraduation: 'Fall 2025',
      status: 'I love business!',
      images: [
        'assets/images/Feed1.png',
      ],
      groupIDs: [
        123,
        456,
      ],
      eventIDs: [
        111,
        222,
      ],
    ),
  ];
}

UsersDB usersDB = UsersDB();
