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
    required this.groupName, // Ex. ICS 466
    required this.semYear, //Ex. Fall 2023
    required this.professor, //Ex. Philip Johnson
    required this.groupMembers, //Ex. 42 (people)
    required this.newMessages, //Ex. 3 (messages)
  });

  final String groupName;
  final String semYear;
  final String professor;
  int groupMembers;
  int newMessages;

}

///Provides access to and operations on all defined groups.
class GroupsDB {
  final List<Group> allGroups = [
      Group(
        groupName: 'ICS 466',
        semYear: 'Fall 2023',
        professor: 'Philip Johnson',
        groupMembers: 42,
        newMessages: 3,
      ),
      Group(
        groupName: 'ICS 332',
        semYear: 'Fall 2023',
        professor: 'Henri Casanova',
        groupMembers: 37,
        newMessages: 17,
      ),
      Group(
        groupName: 'ICS 312',
        semYear: 'Fall 2023',
        professor: 'Kim Binsted',
        groupMembers: 25,
        newMessages: 0,
      ),
      Group(
        groupName: 'Math 307',
        semYear: 'Fall 2023',
        professor: 'Julian Hachmeister',
        groupMembers: 42,
        newMessages: 10,
      ),
      Group(
        groupName: 'ICS 496',
        semYear: 'Fall 2023',
        professor: 'Anthony Peruma',
        groupMembers: 30,
        newMessages: 2,
      ),
    ];

  Group getGroup(String groupName) {
    return allGroups.firstWhere((group) => group.groupName == groupName);
  }

  List<Group> getGroups() {
    return allGroups;
  }//loadGroups
} //Groups Repository

GroupsDB groupsDB = GroupsDB();