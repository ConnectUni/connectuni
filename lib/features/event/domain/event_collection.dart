import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';
import 'event.dart';

/// Encapsulates operations on the list of [Event] returned from Firestore.
class EventCollection {
  EventCollection(events) : _events = events;

  final List<SingleEvent> _events;

  SingleEvent getEvent(String eventID) {
    return _events.firstWhere((data) => data.eventID == eventID);
  }

  List<SingleEvent> getEvents(List<String> eventIDs) {
    return _events.where((data) => eventIDs.contains(data.eventID)).toList();
  }

  int size() {
    return _events.length;
  }

  String getNewID() {
    String result = '';
    switch (size()) {
      case < 10:
        result = 'event-00${size() + 1}';
        break;
      case < 100:
        result = 'event-0${size() + 1}';
        break;
      default:
        result = 'event-${size() + 1}';
    }
    return result;
  }

  List<SingleEvent> getAllEvents() {
    return _events;
  }

  List<String> getAllEventIDs() {
    return _events.map((data) => data.eventID).toList();
  }

  List<String> getEventIDsInGroup(String groupID) {
    return _events.where((data) => data.groupID == groupID).map((data) => data.eventID).toList();
  }

  String getEventName(String eventID) {
    return getEvent(eventID).eventName;
  }

  String getEventLocation(String eventID) {
    return getEvent(eventID).eventLocation;
  }

  String getEventDate(String eventID) {
    return getEvent(eventID).eventDate;
  }

  String getEventDesc(String eventID) {
    return getEvent(eventID).eventDescription;
  }

  List<String> getEventInterests(String eventID) {
    return getEvent(eventID).interests;
  }

  List<String> getUserIDsInEvent(String eventID) {
    return getEvent(eventID).userIDs;
  }

  List<User> getUsersInEvent(UserCollection users, String eventID) {
    return users.getUsers(getUserIDsInEvent(eventID));
  }
}
