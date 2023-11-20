import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/event_database.dart';
import '../data/event_providers.dart';
import '../domain/event.dart';

part 'edit_event_controller.g.dart';

@riverpod
class EditEventController extends _$EditEventController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  // Invoked to add a new event or edit an existing one.
  Future<void> updateEvent({
    required SingleEvent event,
    required VoidCallback onSuccess,
  }) async {
    EventDatabase eventDatabase = ref.watch(eventDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => eventDatabase.setEvent(event));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }

  Future<void> deleteEvent({
    required SingleEvent event,
    required VoidCallback onSuccess,
  }) async {
    EventDatabase eventDatabase = ref.watch(eventDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => eventDatabase.deleteEvent(event));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}
