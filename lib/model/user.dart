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
  List<User> friends;
  List<String> images;
  List<String> groupIDs;
  List<String> eventIDs;

  /// constructor
  User(
      this.uid,
      this.email,
      this.displayName,
      this.pfp,
      this.major,
      this.projectedGraduation,
      this.status,
      this.friends,
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

  /// Add User to friends list.
  void addFriend(User newFriend) {
    friends.add(newFriend);
  }

  /// Delete User from friends list.
  void deleteFriend(User deleteFriend) {
    friends.remove(deleteFriend);
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

  List<String> getImages() {
    return images;
  }

  List<String> getGroupIDs() {
    return groupIDs;
  }

  List<String> getEventIDs() {
    return eventIDs;
  }
}

//firebase -> automatically has the getter/setter methods?
class UsersDB {
  final List<User> allUsers = [
    User(
      '1',
      'braddahal@foo.edu',
      'Albert Flores',
      'assets/images/albert.png',
      'Computer Science',
      'Spring 2024',
      'Almost Friday!',
      [
        //he has no friends
      ],
      [
        'assets/images/Feed1.png',
      ],
      [
        '123',
        '456',
      ],
      [
        '111',
        '222',
      ],
    ),
    User(
      '2',
      'bmiller@foo.edu',
      'Bella Miller',
      'assets/images/bella.png',
      'Liberal Arts',
      'Fall 2025',
      'I need a nap.',
      [],
      [
        'assets/images/Feed1.png',
      ],
      [
        '123',
        '456',
      ],
      [
        '111',
        '222',
      ],
    ),
    User(
      '3',
      'coolcaleb@foo.edu',
      'Caleb Smith',
      'assets/images/caleb.png',
      'Mathematics',
      'Fall 2023',
      'I love math!',
      [
        //no friends
      ],
      [
        'assets/images/Feed1.png',
      ],
      [
        '123',
        '456',
      ],
      [
        '111',
        '222',
      ],
    ),
    User(
      '4',
      'dbonejones@foo.edu',
      'Diana Jones',
      'assets/images/diana.png',
      'Graphic Design',
      'Spring 2024',
      'I love art!',
      [
        //no friends
      ],
      [
        'assets/images/Feed1.png',
      ],
      [
        '123',
        '456',
      ],
      [
        '111',
        '222',
      ],
    ),
    User(
      '5',
      'brown@foo.edu',
      'Ethan Brown',
      'assets/images/ethan.png',
      'Business',
      'Fall 2025',
      'I love business!',
      [
        //no friends
      ],
      [
        'assets/images/Feed1.png',
      ],
      [
        '123',
        '456',
      ],
      [
        '111',
        '222',
      ],
    ),
    User(
      uid: 'user-006',
      email: 'braddahal@foo.edu',
      displayName: 'Albert Flores',
      photoURL: 'assets/images/albert.png',
      major: 'Computer Science',
      projectedGraduation: 'Spring 2024',
      status: 'Almost Friday!',
    ),
  ];

  /**SHOULD BE IN A GROUP CLASS*/

  /// Return single User object, search with their name.
  User getUserByName(String name) {
    return allUsers.firstWhere((user) => user.displayName == name);
  }

  /// Return single User object, search with their UH ID number.
  /// related: cannot change uid to be int type - throw errors
  User getUserByID(String id) {
    return allUsers.firstWhere((user) => user.uid == id);
  }

  /// Return single User object, search with their email.
  User getUserByEmail(String email) {
    return allUsers.firstWhere((user) => user.email == email);
  }


  /// Return list of User objects.
  /// should be in a Group object class
  Iterable<User> getGroupMembers(List<String> memberIds) {
    return allUsers.where((user) => memberIds.contains(user.uid));
  }
  
  List<User> getUsers() {
    return allUsers;
  }
}

UsersDB usersDB = UsersDB();
