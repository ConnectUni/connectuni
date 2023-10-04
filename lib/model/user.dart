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
      uid: '1',
      email: 'braddahal@foo.edu',
      displayName: 'Albert Flores',
      photoURL: 'assets/images/albert.png',
      major: 'Computer Science',
      projectedGraduation: 'Spring 2024',
      status: 'Almost Friday!',
    ),
    User(
      uid: '2',
      email: 'bmiller@foo.edu',
      displayName: 'Bella Miller',
      photoURL: 'assets/images/bella.png',
      major: 'Liberal Arts',
      projectedGraduation: 'Fall 2025',
      status: 'I need a nap.',
    ),
    User(
      uid: '3',
      email: 'coolcaleb@foo.edu',
      displayName: 'Caleb Smith',
      photoURL: 'assets/images/caleb.png',
      major: 'Mathematics',
      projectedGraduation: 'Fall 2023',
      status: 'I love math!',
    ),
    User(
      uid: '4',
      email: 'dbonejones@foo.edu',
      displayName: 'Diana Jones',
      photoURL: 'assets/images/diana.png',
      major: 'Graphic Design',
      projectedGraduation: 'Spring 2024',
      status: 'I love art!',
    ),
    User(
      uid: '5',
      email: 'brown@foo.edu',
      displayName: 'Ethan Brown',
      photoURL: 'assets/images/ethan.png',
      major: 'Business',
      projectedGraduation: 'Fall 2025',
      status: 'I love business!',
    ),
  ];

  User getUser(String uid) {
    return allUsers.firstWhere((user) => user.uid == uid);
  }

  List<User> getUsers() {
    return allUsers;
  }
}

UsersDB usersDB = UsersDB();
