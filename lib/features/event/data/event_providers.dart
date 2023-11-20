import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

import '../domain/event.dart';
import 'event_database.dart';

part 'event_providers.g.dart';

@riverpod
EventDatabase eventDatabase(EventDatabaseRef ref) {
  return EventDatabase(ref);
}

@riverpod
Stream<List<SingleEvent>> events(EventsRef ref) {
  final database = ref.watch(eventDatabaseProvider);
  return database.watchEvents();
}

@riverpod
class FilteredEvents extends _$FilteredEvents {
  bool mounted = true;
  List<SingleEvent> events = [];
  List<SingleEvent> results = [];
  List<String> filters = [];
  String query = '';

  @override
  FutureOr<List<SingleEvent>> build() async {
    ref.onDispose(() => mounted = false);
    events = await ref.watch(eventsProvider.future);
    return events;
  }

  void _updateResults() {
    if (query.isEmpty && filters.isEmpty) {
      results = events;
    } else {
      results = events.where((event) {
        if (filters.isNotEmpty) {
          return event.eventName
              .toLowerCase()
              .contains(query.toLowerCase()) && event.interests
              .any((interests) => filters.contains(interests));
        } else {
          return event.eventName
              .toLowerCase()
              .contains(query.toLowerCase());
        }
      }).toList();
    }
    if (mounted) {
      state = AsyncData(results);
    }
  }

  void filterQuery(String input) {
    query = input;
    _updateResults();
  }

  void updateFilters(List<String> filters) {
    this.filters = filters;
    _updateResults();
  }
}

@riverpod
class FilteredSelectedEvents extends _$FilteredSelectedEvents {
  bool mounted = true;
  List<SingleEvent> events = [];
  List<SingleEvent> results = [];
  List<String> filters = [];

  @override
  FutureOr<List<SingleEvent>> build() async {
    ref.onDispose(() => mounted = false);
    events = await ref.watch(eventsProvider.future);
    return events;
  }

  void _updateResults() {
    if (filters.isEmpty) {
      results = events;
    } else {
      results = events.where((event) => filters.contains(event.groupID)).toList();
    }
    if (mounted) {
      state = AsyncData(results);
    }
  }

  void updateFilters(List<String> filters) {
    this.filters = filters;
    _updateResults();
  }
}

@riverpod
class SelectedEvents extends _$SelectedEvents {
  bool mounted = true;
  List<SingleEvent> events = [];
  List<SingleEvent> results = [];
  DateTime focusDay = DateTime.now();
  DateTime? selectedDay;

  @override
  Future<List<SingleEvent>> build() async {
    ref.onDispose(() => mounted = false);
    events = await ref.watch(filteredSelectedEventsProvider.future);
    _updateSelectedEvents();
    return results;
  }

  void _updateSelectedEvents() {
    selectedDay ??= focusDay;
    results = events.where((event) => isSameDay(DateTime.tryParse(event.eventDate), selectedDay!)).toList();
    state = AsyncData(results);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
      this.selectedDay = selectedDay;
      focusDay = focusedDay;
      _updateSelectedEvents();
    }
  }
}
