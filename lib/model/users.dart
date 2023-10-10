import 'user.dart';

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
