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
    required this.images,
    required this.groupIDs,
    required this.eventIDs,
  });

  final String uid;
  final String email;
  final String displayName;
  final String photoURL;
  final String major;
  final String projectedGraduation;
  final String status;
  final List<String> images;
  final List<int> groupIDs;
  final List<int> eventIDs;
}

class UsersDB {
  final List<User> allUsers = [
    User(
      uid: '1',
      email: 'braddahal@foo.edu',
      displayName: 'Albert Flores',
      photoURL: 'assets/images/albert.png',
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
      photoURL: 'assets/images/bella.png',
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
      photoURL: 'assets/images/caleb.png',
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
      photoURL: 'assets/images/diana.png',
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
      photoURL: 'assets/images/ethan.png',
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

  User getUserByName(String name) {
    for (int i = 0; i < allUsers.length; i++) {
      print(allUsers[i].uid);
    }

    return allUsers.firstWhere((user) => user.uid == name);
  }

  List<User> getUsers() {
    return allUsers;
  }
}

UsersDB usersDB = UsersDB();
