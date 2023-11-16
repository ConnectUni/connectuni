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
