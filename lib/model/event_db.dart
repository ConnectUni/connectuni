/**
 * Generic outline of the different events that will be described by each page.
 */

///The data associated with events.
class Event {
  Event({
    required this.eventId, //Ex. 'event-001'
    required this.eventName, // Ex. 'Pizza Party'
    required this.eventIcon, //Ex. 'pizza.png'
    required this.eventLocation, //Ex. 'Hamilton Library'
    required this.eventDescription, //Ex. 'Come join us for a pizza party!'
    required this.eventDate, //Ex. DateTime(2023, 10, 13, 12, 30)
    required this.groupId,  //Ex. 'group-001'
    required this.userIds,  //Ex. ['user-001', 'user-002', 'user-003']
  });

  final String eventId;
  final String eventName;
  String eventIcon;
  String eventLocation;
  String eventDescription;
  final DateTime eventDate;
  final String groupId;
  List<String> userIds;

  ///Setter methods:
  //Setter method that updates the Event Icon.
  void updateEventIcon(String newIcon) {
    eventIcon = newIcon;
  }
  //Setter method that adds a user to the event.
  void addUser(String userId) {
    userIds.add(userId);
  }
  //Setter method that removes a user from the event.
  void removeUser(String userId) {
    userIds.remove(userId);
  }
  //Setter method that updates the event description.
  void updateEventDescription(String newDescription) {
    eventDescription = newDescription;
  }
  //Setter method that updates the event location.
  void updateEventLocation(String newLocation) {
    eventLocation = newLocation;
  }
  ///Getter methods:
    bool isUserInEvent(String userId) {
      return userIds.contains(userId);
    }
}

///Provides access to and operations on all defined groups.
class EventsDB {
  //Example data for events.
  List<Event> allEvents = [
    Event(
      eventId: 'event-001',
      eventName: 'ICS 466 Pizza Party',
      eventIcon: 'assets/images/pizzaparty.jpg',
      eventLocation: 'Keller 102',
      eventDescription: 'Come join us for a pizza party!',
      eventDate: DateTime(2023, 10, 13, 12, 30),
      groupId: 'group-001',
      userIds: ['user-001', 'user-002', 'user-003'],
    ),
    Event(
      eventId: 'event-002',
      eventName: 'ICS 332 Study Session',
      eventIcon: 'assets/images/studysesh.jpg',
      eventLocation: 'ICSpace',
      eventDescription: 'Study session for the upcoming ICS 332 Quiz. Come join us!',
      eventDate: DateTime(2023, 10, 9, 9, 00),
      groupId: 'group-002',
      userIds: ['user-001'],
    ),
    Event(
      eventId: 'event-003',
      eventName: 'MATH 307 Bowling Outing',
      eventIcon: 'assets/images/aieabowl.jpg',
      eventLocation: 'Aiea Bowl',
      eventDescription: 'Annual Math 307 Bowling competition. Any experience is welcome! Five dollar entrance fee though.',
      eventDate: DateTime(2023, 10, 25, 18, 30),
      groupId: 'group-003',
      userIds: ['user-002', 'user-003'],
    ),
    Event(
      eventId: 'event-004',
      eventName: 'Final Exam Date',
      eventIcon: 'assets/images/finalexam.jpg',
      eventLocation: 'TBD',
      eventDescription: 'Final Exam for ICS 466.',
      eventDate: DateTime(2023, 11, 3, 7, 30),
      groupId: 'group-001',
      userIds: ['user-001', 'user-002'],
    ),
  ];
  ///SETTER METHODS:

  //Setter methods that add and remove events respectively.
  void addEvent(Event newEvent) {
    allEvents.add(newEvent);
  }
  void removeEvent(Event event) {
    allEvents.remove(event);
  }
  ///GETTER METHODS:
  //Getter methods that return events based on their event ID, name, and group ID respectively.
  Event getEventById(String eventId) {
    return allEvents.firstWhere((event) => event.eventId == eventId);
  }
  Event getEventByName(String eventName) {
    return allEvents.firstWhere((event) => event.eventName == eventName);
  }
  List<Event> getEventsByGroupId(String groupId) {
    return allEvents.where((event) => event.groupId == groupId).toList();
  }

  //Getter method that returns all events.
  List<Event> getAllEvents() {
    return allEvents;
  }//loadGroups
} //Groups Repository

EventsDB eventsDB = EventsDB();
