// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventDatabaseHash() => r'6c3388489150ea2a9a33d37cd49a0ee03243b732';

/// See also [eventDatabase].
@ProviderFor(eventDatabase)
final eventDatabaseProvider = AutoDisposeProvider<EventDatabase>.internal(
  eventDatabase,
  name: r'eventDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EventDatabaseRef = AutoDisposeProviderRef<EventDatabase>;
String _$eventsHash() => r'b93f55ac84d2af754981db6308879d9a7c4183f4';

/// See also [events].
@ProviderFor(events)
final eventsProvider = AutoDisposeStreamProvider<List<SingleEvent>>.internal(
  events,
  name: r'eventsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$eventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EventsRef = AutoDisposeStreamProviderRef<List<SingleEvent>>;
String _$filteredEventsHash() => r'd2b80299a717708a5bae0ceed16f3b4ca6531655';

/// See also [FilteredEvents].
@ProviderFor(FilteredEvents)
final filteredEventsProvider = AutoDisposeAsyncNotifierProvider<FilteredEvents,
    List<SingleEvent>>.internal(
  FilteredEvents.new,
  name: r'filteredEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FilteredEvents = AutoDisposeAsyncNotifier<List<SingleEvent>>;
String _$selectedEventsHash() => r'8651588cbd01aca619885dce574a5463ab44e6b0';

/// See also [SelectedEvents].
@ProviderFor(SelectedEvents)
final selectedEventsProvider = AutoDisposeAsyncNotifierProvider<SelectedEvents,
    List<SingleEvent>>.internal(
  SelectedEvents.new,
  name: r'selectedEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedEvents = AutoDisposeAsyncNotifier<List<SingleEvent>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
