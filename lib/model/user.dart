/**
 * This file contains the User class and the UsersDB class.
 * Generic outline of the different users that will be described by each page.
 * 
 * Last updated: 10/10 added interests field and setter method.
 *
 */

///The data associated with users.
class User {
  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.major,
    required this.projectedGraduation,
    required this.status,
    required this.interests,
  });

  final String uid;
  final String email;
  String displayName;
  String photoURL;
  String major;
  String projectedGraduation;
  String status;
  List<String> interests;

  ///SETTER METHODS:
  //Setter method for updating the user's display name.
  void updateDisplayName(String displayName) {
    this.displayName = displayName;
  }
  //Setter method for updating the user's photo URL.
  void updatePhotoURL(String photoURL) {
    this.photoURL = photoURL;
  }
  //Setter method for updating the user's major.
  void updateMajor(String major) {
    this.major = major;
  }
  //Setter method for updating the user's projected graduation.
  void updateProjectedGraduation(String projectedGraduation) {
    this.projectedGraduation = projectedGraduation;
  }
  //Setter method for updating the user's status.
  void updateStatus(String status) {
    this.status = status;
  }
  //Setter method for adding an interest to the user.
  void addInterest(String interest) {
    interests.add(interest);
  }
}

class UsersDB {
  final List<User> allUsers =[
    User(
      uid: 'user-001',
      email: 'aritter@foo.edu',
      displayName: 'Alberta Ritter',
      photoURL: 'assets/images/You.jpg',
      major: 'Computer Science',
      projectedGraduation: 'Fall 2024',
      status: 'I love computer science!',
      interests: ['Computer Science', 'Mathematics', 'Business'],
    ),
    User(
      uid: 'user-002',
      email: 'bmiller@foo.edu',
      displayName: 'Bella Miller',
      photoURL: 'assets/images/bella.png',
      major: 'Liberal Arts',
      projectedGraduation: 'Fall 2025',
      status: 'I need a nap.',
      interests: [],
    ),
    User(
      uid: 'user-003',
      email: 'coolcaleb@foo.edu',
      displayName: 'Caleb Smith',
      photoURL: 'assets/images/caleb.png',
      major: 'Mathematics',
      projectedGraduation: 'Fall 2023',
      status: 'I love math!',
      interests: ['Mathematics', 'Computer Science'],
    ),
    User(
      uid: 'user-004',
      email: 'dbonejones@foo.edu',
      displayName: 'Diana Jones',
      photoURL: 'assets/images/diana.png',
      major: 'Graphic Design',
      projectedGraduation: 'Spring 2024',
      status: 'I love art!',
      interests: ['Art', 'Graphic Design'],
    ),
    User(
      uid: 'user-005',
      email: 'brown@foo.edu',
      displayName: 'Ethan Brown',
      photoURL: 'assets/images/ethan.png',
      major: 'Business',
      projectedGraduation: 'Fall 2025',
      status: 'I love business!',
      interests: ['Business', 'Computer Science'],
    ),
    User(
      uid: 'user-006',
      email: 'braddahal@foo.edu',
      displayName: 'Albert Flores',
      photoURL: 'assets/images/albert.png',
      major: 'Computer Science',
      projectedGraduation: 'Spring 2024',
      status: 'Almost Friday!',
      interests: ['Computer Science', 'Mathematics'],
    ),
  ];

  User getUser(String uid) {
    return allUsers.firstWhere((user) => user.uid == uid);
  }

  Iterable<User> getGroupMembers(List<String> memberIds) {
    return allUsers.where((user) => memberIds.contains(user.uid));
  }

  List<User> getUsers() {
    return allUsers;
  }
}

UsersDB usersDB = UsersDB();
