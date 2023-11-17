import 'user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

/// The UserList object.
class UserList {
  List<User> allUsers;

  /// Constructor
  UserList(this.allUsers);

  /// Return number of Group Objects
  int userLength() {
    return allUsers.length;
  }

  /// Return single User object, search with their name.
  User getUserByName(String name) {
    return allUsers.firstWhere((user) => user.displayName == name);
  }

  /// Return single User object, search with their UH ID number.
  User getUserByID(String id) {
    return allUsers.firstWhere((user) => user.uid == id);
  }

  /// Return single User object, search with their email.
  User? getUserByEmail(String email) {
    return allUsers.firstWhereOrNull((user) => user.email == email);
  }

  /// Return single User object, search with their email.
  User? getUserByPotentialEmail(String? email) {
    if(email == null) return null;
    return allUsers.firstWhereOrNull((user) => user.email == email);
  }

  /// Return iterable list of User objects.
  Iterable<User> getGroupMembers(List<String> memberIds) {
    return allUsers.where((user) => memberIds.contains(user.uid));
  }

  /// Return list of User objects.
  List<User> getUsers() {
    return allUsers;
  }

  /// Add a user
  void addUser(User user) {
    allUsers.add(user);
  }

  void updateUser ({
  required String uid,
    required String email,
    required String displayName,
    required String pfp,
    required String major,
    required String projectedGraduation,
    required String status,
    required List<User> friends,
    required List<String> groupIDs,
    required List<String> eventIDs,
    required List<String> interests,
  }) {
    allUsers.removeWhere((user) => user.uid == uid);
    allUsers.add(
      User(
        uid: uid,
        email: email,
        displayName: displayName,
        pfp: pfp,
        major: major,
        projectedGraduation: projectedGraduation,
        status: status,
        friends: friends,
        groupIDs: groupIDs,
        eventIDs: eventIDs,
        interests: interests,
      ),
    );
  }
}

/// DELETE THIS BOTTOM SECTION AFTER GETTING REAL DB

final User friend1 = User(
  uid: 'user-006',
  email: 'email@one.edu',
  displayName: 'Friend1',
  pfp: '',
  major: 'Finance',
  projectedGraduation: 'December 2025',
  status: 'School makes me wanna wake up every morning!',
  friends: [],
  groupIDs: ['group-456'],
  eventIDs: ['event-111'],
  interests: ['Finance', 'Business'],
);

final User friend2 = User(
  uid: 'user-007',
  email: 'email@two.edu',
  displayName: 'Friend2',
  pfp: '',
  major: 'Finance',
  projectedGraduation: 'May 2025',
  status: 'I never wanna leave school!',
  friends: [friend1],
  groupIDs:['group-123'],
  eventIDs: ['event-222'],
  interests: [],
);

/// The mock users DB
final List<User> mockUsers = [
  User(
    uid: 'user-001',
    email: 'braddahal@foo.edu',
    displayName: 'Albert Flores',
    pfp: 'assets/images/albert.png',
    major: 'Computer Science',
    projectedGraduation: 'Spring 2024',
    status: 'Almost Friday!',
    friends: [
      friend1,
    ],
    groupIDs:[
      'group-123',
      'group-456',
    ],
    eventIDs: [
      'event-111',
      'event-222',
    ],
    interests: ['Mathematics', 'Computer Science'],
  ),
  User(
    uid: 'user-002',
    email: 'bmiller@foo.edu',
    displayName: 'Bella Miller',
    pfp: 'assets/images/bella.png',
    major: 'Liberal Arts',
    projectedGraduation: 'Fall 2025',
    status: 'I need a nap.',
    friends: [
      friend1,
      friend2,
    ],
    groupIDs:[
      'group-123',
    ],
    eventIDs: [
      'event-111',
      'event-333',
    ],
    interests: ['Art', 'Graphic Design'],
  ),
  User(
    uid: 'user-003',
    email: 'coolcaleb@foo.edu',
    displayName: 'Caleb Smith',
    pfp: 'assets/images/caleb.png',
    major: 'Mathematics',
    projectedGraduation: 'Fall 2023',
    status: 'I love math!',
    friends: [
      friend2,
    ],
    groupIDs:[
      'group-456',
    ],
    eventIDs: [
      'event-222',
      'event-333',
    ],
    interests: ['Business', 'Computer Science'],
  ),
  User(
    uid: 'user-004',
    email: 'dbonejones@foo.edu',
    displayName: 'Diana Jones',
    pfp: 'assets/images/diana.png',
    major: 'Graphic Design',
    projectedGraduation: 'Spring 2024',
    status: 'I love art!',
    friends: [
      friend1,
    ],
    groupIDs:[
      'group-789',
      'group-456',
    ],
    eventIDs: [
      'event-111',
      'event-222',
    ],
    interests: [],
  ),
  User(
    uid: 'user-005',
    email: 'brown@foo.edu',
    displayName: 'Ethan Brown',
    pfp: 'assets/images/ethan.png',
    major: 'Business',
    projectedGraduation: 'Fall 2025',
    status: 'I love business!',
    friends: [
      friend1,
      friend2,
    ],
    groupIDs:[
      'group-123',
      'group-456',
      'group-789',
    ],
    eventIDs: [
      'event-111',
      'event-222',
      'event-333',
    ],
    interests: ['Computer Science', 'Mathematics'],
  ),
  friend1,
  friend2,
  User(
    uid: 'user-008',
    email: 'kenjisan@hawaii.edu',
    displayName: 'Kenji Sanehira',
    pfp: 'assets/images/Kenji.jpg',
    major: 'Computer Science',
    projectedGraduation: 'Spring 2024',
    status: 'This is an annoying test',
    friends: [
      friend1,
    ],
    groupIDs:[
      'group-123',
      'group-456',
    ],
    eventIDs: [
      'event-111',
      'event-222',
    ],
    interests: ['Computer Science'],
  ),
];

//TODO: REMOVE THIS LATER WHEN WE FIGURE OUT HOW TO WORK BETWEEN THESE TWO.
UserList TempUsersDB = UserList(mockUsers);

//User currentUser = usersDB.getUserByID('user-001');
