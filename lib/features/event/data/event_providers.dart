import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/event.dart';
import '../domain/event_list.dart';

//TODO: USE BELOW
final eventsDBProvider = Provider<EventList>((ref) { return EventList(allEvents); });

/*
 * These are the state providers that will be used to check the selected
 * interests and the search query.
 */
final selectedFiltersProvider = StateProvider<List<String>?>((ref) => []);
final searchQueryProvider = StateProvider<String?>((ref) => "");

/*
 * This provider will be used to filter the events based on the selected
 * interests and the search query from the providers above.
 */
final filteredEvents = Provider<List<SingleEvent>?>((ref) {
  final filters = ref.watch(selectedFiltersProvider);
  final events = ref.watch(eventsDBProvider).getAllEvents();
  final query = ref.watch(searchQueryProvider);
  final suggestions = events.where((event) {
    if(filters!.isNotEmpty) {
      return event.eventName.toLowerCase().contains(query!.toLowerCase()) && event.interests.any((interest) => filters.contains(interest));
    } else {
      return event.eventName.toLowerCase().contains(query!.toLowerCase());
    }
  }).toList();

  return suggestions;
});
