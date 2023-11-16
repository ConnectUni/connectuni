import 'event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The EventList object.
class EventList {
  List<SingleEvent> allEvents;

  ///Constructor
  EventList(this.allEvents);

  /// Add an Event
  void addEvent(SingleEvent newEvent) {
    allEvents.add(newEvent);
  }

  /// Remove an Event
  void removeEvent(SingleEvent event) {
    if (allEvents.contains(event)) {
      allEvents.remove(event);
    }
  }

  /// Return single Event object, search by its eventID
  SingleEvent getEventById(String eventId) {
    return allEvents.firstWhere((event) => event.eventID == eventId);
  }

  /// Return single Event object, search by its eventName
  SingleEvent getEventByName(String eventName) {
    return allEvents.firstWhere((event) => event.eventName == eventName);
  }

  /// Return list of Event objects, search by groupID
  List<SingleEvent> getEventsByGroupId(String groupID) {
    return allEvents.where((event) => event.groupID == groupID).toList();
  }

  /// Return allEvents
  List<SingleEvent> getAllEvents() {
    return allEvents;
  }
}

/// DELETE THIS BOTTOM SECTION AFTER GETTING REAL DB
List<SingleEvent> allEvents = [
  /**
  SingleEvent(
    eventID: 'event-001',
    eventName: 'ICS 466 Pizza Party',
    eventIcon: 'assets/images/pizzaparty.jpg',
    eventLocation: 'Keller 102',
    eventDescription: 'Come join us for a pizza party!',
    eventDate: DateTime(2023, 10, 13, 12, 30),
    groupID: 'group-001',
    userIDs: ['user-001', 'user-002', 'user-003'],
    interests: ['Computer Science'],
  ),
  SingleEvent(
    eventID: 'event-002',
    eventName: 'ICS 332 Study Session',
    eventIcon: 'assets/images/studysesh.jpg',
    eventLocation: 'ICSpace',
    eventDescription:
        'Study session for the upcoming ICS 332 Quiz. Come join us!',
    eventDate: DateTime(2023, 10, 9, 9, 00),
    groupID: 'group-002',
    userIDs: ['user-001'],
    interests: ['Computer Science'],
  ),
  SingleEvent(
    eventID: 'event-003',
    eventName: 'MATH 307 Bowling Outing',
    eventIcon: 'assets/images/aieabowl.jpg',
    eventLocation: 'Aiea Bowl',
    eventDescription:
        'Annual Math 307 Bowling competition. Any experience is welcome! Five dollar entrance fee though.',
    eventDate: DateTime(2023, 10, 25, 18, 30),
    groupID: 'group-003',
    userIDs: ['user-002', 'user-003'],
    interests: ['Mathematics'],
  ),
  SingleEvent(
    eventID: 'event-004',
    eventName: 'Final Exam Date',
    eventIcon: 'assets/images/finalexam.jpg',
    eventLocation: 'TBD',
    eventDescription: 'Final Exam for ICS 466.',
    eventDate: DateTime(2023, 11, 3, 7, 30),
    groupID: 'group-001',
    userIDs: ['user-001', 'user-002'],
    interests: ['Computer Science'],
  ),
      */
];

