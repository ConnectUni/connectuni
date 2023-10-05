/**
 * Generic outline of the different groups that will be described by each page.
 * TODO: Add to this after the UI mockup is completed for actual functionality.
 *
 * Last updated: 9/30 based on UI mockup solely.
 *
 */

///The data associated with groups.
class Group {
  Group({
    required this.groupId, // Ex. group-001, group-002 (Group Ids)
    required this.groupName, // Ex. ICS 466
    required this.semYear, //Ex. Fall 2023
    required this.professor, //Ex. Philip Johnson
    required this.memberIds, //Ex. user-001, user-002 (User Ids)
    required this.groupMembers, //Ex. 42 (people)
    required this.newMessages, //Ex. 3 (messages)
  });

  final String groupId;
  final String groupName;
  final String semYear;
  final String professor;
  final List<String> memberIds;
  int groupMembers;
  int newMessages;

}

///Provides access to and operations on all defined groups.
class GroupsDB {
  final List<Group> allGroups = [
      Group(
        groupId: 'group-001',
        groupName: 'ICS 466',
        semYear: 'Fall 2023',
        professor: 'Philip Johnson',
        memberIds: [
          'user-001',
          'user-002',
          'user-003',
          'user-004',
          'user-005',
        ],
        groupMembers: 42,
        newMessages: 3,
      ),
      Group(
        groupId: 'group-002',
        groupName: 'ICS 332',
        semYear: 'Fall 2023',
        professor: 'Henri Casanova',
        memberIds: [
          'user-001',
          'user-002',
          'user-003',
          'user-004',
          'user-005',
        ],
        groupMembers: 37,
        newMessages: 17,
      ),
      Group(
        groupId: 'group-003',
        groupName: 'ICS 312',
        semYear: 'Fall 2023',
        professor: 'Kim Binsted',
        memberIds: [
          'user-001',
          'user-002',
          'user-003',
          'user-004',
          'user-005',
        ],
        groupMembers: 25,
        newMessages: 0,
      ),
      Group(
        groupId: 'group-004',
        groupName: 'Math 307',
        semYear: 'Fall 2023',
        professor: 'Julian Hachmeister',
        memberIds: [
          'user-001',
          'user-002',
          'user-003',
          'user-004',
          'user-005',
        ],
        groupMembers: 42,
        newMessages: 10,
      ),
      Group(
        groupId: 'group-005',
        groupName: 'ICS 496',
        semYear: 'Fall 2023',
        professor: 'Anthony Peruma',
        memberIds: [
          'user-001',
          'user-002',
          'user-003',
          'user-004',
          'user-005',
        ],
        groupMembers: 30,
        newMessages: 2,
      ),
    ];

  Group getGroup(String groupId) {
    return allGroups.firstWhere((group) => group.groupId == groupId);
  }

  List<Group> getGroups() {
    return allGroups;
  }//loadGroups
} //Groups Repository

GroupsDB groupsDB = GroupsDB();
