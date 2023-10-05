/**
 * This file contains the User class and the UsersDB class.
 * Generic outline of the different users that will be described by each page.
 */
class User {
  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.major,
    required this.projectedGraduation,
    required this.status,
  });

  final String uid;
  final String email;
  final String displayName;
  final String photoURL;
  final String major;
  final String projectedGraduation;
  final String status;

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
    ),
    User(
      uid: 'user-002',
      email: 'bmiller@foo.edu',
      displayName: 'Bella Miller',
      photoURL: 'assets/images/bella.png',
      major: 'Liberal Arts',
      projectedGraduation: 'Fall 2025',
      status: 'I need a nap.',
    ),
    User(
      uid: 'user-003',
      email: 'coolcaleb@foo.edu',
      displayName: 'Caleb Smith',
      photoURL: 'assets/images/caleb.png',
      major: 'Mathematics',
      projectedGraduation: 'Fall 2023',
      status: 'I love math!',
    ),
    User(
      uid: 'user-004',
      email: 'dbonejones@foo.edu',
      displayName: 'Diana Jones',
      photoURL: 'assets/images/diana.png',
      major: 'Graphic Design',
      projectedGraduation: 'Spring 2024',
      status: 'I love art!',
    ),
    User(
      uid: 'user-005',
      email: 'brown@foo.edu',
      displayName: 'Ethan Brown',
      photoURL: 'assets/images/ethan.png',
      major: 'Business',
      projectedGraduation: 'Fall 2025',
      status: 'I love business!',
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
