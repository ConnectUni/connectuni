import 'user.dart';

/// The UserList object.
class UserList {
  List<User> allUsers;

  /// Constructor
  UserList(this.allUsers);

  /// Return single User object, search with their name.
  User getUserByName(String name) {
    return allUsers.firstWhere((user) => user.displayName == name);
  }

  /// Return single User object, search with their UH ID number.
  User getUserByID(String id) {
    return allUsers.firstWhere((user) => user.uid == id);
  }

  /// Return single User object, search with their email.
  User getUserByEmail(String email) {
    return allUsers.firstWhere((user) => user.email == email);
  }

  /// Return iterable list of User objects.
  Iterable<User> getGroupMembers(List<String> memberIds) {
    return allUsers.where((user) => memberIds.contains(user.uid));
  }

  /// Return list of User objects.
  List<User> getUsers() {
    return allUsers;
  }
}

/// DELETE THIS BOTTOM SECTION AFTER GETTING REAL DB
final List<User> mockUsers = [
  User(
    'uid-001',
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
      'group-123',
      'group-456',
    ],
    [
      'event-111',
      'event-222',
    ],
  ),
  User(
    'uid-002',
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
      'group-123',
    ],
    [
      'event-111',
      'event-333',
    ],
  ),
  User(
    'uid-003',
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
      'group-456',
    ],
    [
      'event-222',
      'event-333',
    ],
  ),
  User(
    'uid-004',
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
      'group-789',
      'group-456',
    ],
    [
      'event-111',
      'event-222',
    ],
  ),
  User(
    'uid-005',
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
      'group-123',
      'group-456',
      'group-789',
    ],
    [
      'event-111',
      'event-222',
      'event-333',
    ],
  ),
];

UserList usersDB = UserList(mockUsers);
