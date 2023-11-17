import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    state = const AsyncLoading();
    if (query.isEmpty && filters.isEmpty) {
      results = events;
    } else {
      results = events.where((event) => event.eventName
          .toLowerCase()
          .contains(query.toLowerCase()) && event.interests
          .any((interests) => filters.contains(interests)))
          .toList();
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
