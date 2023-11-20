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
String _$filteredEventsHash() => r'93831098d6f336a7bf1e524373f751fa9b8dc95d';

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
String _$filteredSelectedEventsHash() =>
    r'0aa4598fc1cb0eb8b6f7e63b57e12c5cea5e77d4';

/// See also [FilteredSelectedEvents].
@ProviderFor(FilteredSelectedEvents)
final filteredSelectedEventsProvider = AutoDisposeAsyncNotifierProvider<
    FilteredSelectedEvents, List<SingleEvent>>.internal(
  FilteredSelectedEvents.new,
  name: r'filteredSelectedEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredSelectedEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FilteredSelectedEvents = AutoDisposeAsyncNotifier<List<SingleEvent>>;
String _$selectedEventsHash() => r'90f7ec1a5966354d28a13ed9cf79495a2001c733';

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
