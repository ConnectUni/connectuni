/**
 * Generic outline of the different groups that will be described by each page.
 * TODO: Add to this after the UI mockup is completed for actual functionality.
 *
 * Last updated: 9/30 based on UI mockup solely.
 *
 */

//TODO: Add a category to sort on

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