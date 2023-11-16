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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
