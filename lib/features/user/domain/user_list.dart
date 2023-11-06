import 'user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  String getPassword(String email) {
    return getUserByEmail(email).getPassword();
  }
}

/// DELETE THIS BOTTOM SECTION AFTER GETTING REAL DB

final User friend1 = User(
  'user-111',
  'email@one.edu',
  'Friend1',
  '',
  'Finance',
  'December 2025',
  'School makes me wanna wake up every morning!',
  [],
  ['assets/images/friend.png'],
  ['group-456'],
  ['event-111'],
  ['Finance', 'Business'],
  'password',
);

final User friend2 = User(
  'user-222',
  'email@two.edu',
  'Friend2',
  '',
  'Finance',
  'May 2025',
  'I never wanna leave school!',
  [friend1],
  ['assets/images/friend.png'],
  ['group-123'],
  ['event-222'],
  [],
  'changeme',
);

/// The mock users DB
final List<User> mockUsers = [
  User(
    'user-001',
    'braddahal@foo.edu',
    'Albert Flores',
    'assets/images/albert.png',
    'Computer Science',
    'Spring 2024',
    'Almost Friday!',
    [
      friend1,
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
    ['Mathematics', 'Computer Science'],
    'imthebest',
  ),
  User(
    'user-002',
    'bmiller@foo.edu',
    'Bella Miller',
    'assets/images/bella.png',
    'Liberal Arts',
    'Fall 2025',
    'I need a nap.',
    [
      friend1,
      friend2,
    ],
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
    ['Art', 'Graphic Design'],
    'noimthebest',
  ),
  User(
    'user-003',
    'coolcaleb@foo.edu',
    'Caleb Smith',
    'assets/images/caleb.png',
    'Mathematics',
    'Fall 2023',
    'I love math!',
    [
      friend2,
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
    ['Business', 'Computer Science'],
    'calebsmith',
  ),
  User(
    'user-004',
    'dbonejones@foo.edu',
    'Diana Jones',
    'assets/images/diana.png',
    'Graphic Design',
    'Spring 2024',
    'I love art!',
    [
      friend1,
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
    [],
    'dianajones1',
  ),
  User(
    'user-005',
    'brown@foo.edu',
    'Ethan Brown',
    'assets/images/ethan.png',
    'Business',
    'Fall 2025',
    'I love business!',
    [
      friend1,
      friend2,
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
    ['Computer Science', 'Mathematics'],
    'brownisthebest',
  ),
  friend1,
  friend2,
];

//TODO: REMOVE THIS LATER WHEN WE FIGURE OUT HOW TO WORK BETWEEN THESE TWO.
UserList TempUsersDB = UserList(mockUsers);

//User currentUser = usersDB.getUserByID('user-001');
