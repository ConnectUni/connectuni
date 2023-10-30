import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/event_list.dart';

//TODO: Replace all instances of TempEventsDB with the provider below
EventList TempEventsDB = EventList(allEvents);
//TODO: USE BELOW
final eventsDBProvider = Provider<EventList>((ref) { return EventList(allEvents); });
