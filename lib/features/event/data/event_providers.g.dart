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
String _$selectedEventsHash() => r'5c5e2a79a1e37ca18f13ec69ada527aec09c5700';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SelectedEvents
    extends BuildlessAutoDisposeNotifier<List<SingleEvent>> {
  late final List<SingleEvent> initialEvents;

  List<SingleEvent> build(
    List<SingleEvent> initialEvents,
  );
}

/// See also [SelectedEvents].
@ProviderFor(SelectedEvents)
const selectedEventsProvider = SelectedEventsFamily();

/// See also [SelectedEvents].
class SelectedEventsFamily extends Family<List<SingleEvent>> {
  /// See also [SelectedEvents].
  const SelectedEventsFamily();

  /// See also [SelectedEvents].
  SelectedEventsProvider call(
    List<SingleEvent> initialEvents,
  ) {
    return SelectedEventsProvider(
      initialEvents,
    );
  }

  @override
  SelectedEventsProvider getProviderOverride(
    covariant SelectedEventsProvider provider,
  ) {
    return call(
      provider.initialEvents,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedEventsProvider';
}

/// See also [SelectedEvents].
class SelectedEventsProvider
    extends AutoDisposeNotifierProviderImpl<SelectedEvents, List<SingleEvent>> {
  /// See also [SelectedEvents].
  SelectedEventsProvider(
    List<SingleEvent> initialEvents,
  ) : this._internal(
          () => SelectedEvents()..initialEvents = initialEvents,
          from: selectedEventsProvider,
          name: r'selectedEventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedEventsHash,
          dependencies: SelectedEventsFamily._dependencies,
          allTransitiveDependencies:
              SelectedEventsFamily._allTransitiveDependencies,
          initialEvents: initialEvents,
        );

  SelectedEventsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialEvents,
  }) : super.internal();

  final List<SingleEvent> initialEvents;

  @override
  List<SingleEvent> runNotifierBuild(
    covariant SelectedEvents notifier,
  ) {
    return notifier.build(
      initialEvents,
    );
  }

  @override
  Override overrideWith(SelectedEvents Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectedEventsProvider._internal(
        () => create()..initialEvents = initialEvents,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialEvents: initialEvents,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SelectedEvents, List<SingleEvent>>
      createElement() {
    return _SelectedEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedEventsProvider &&
        other.initialEvents == initialEvents;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialEvents.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectedEventsRef on AutoDisposeNotifierProviderRef<List<SingleEvent>> {
  /// The parameter `initialEvents` of this provider.
  List<SingleEvent> get initialEvents;
}

class _SelectedEventsProviderElement extends AutoDisposeNotifierProviderElement<
    SelectedEvents, List<SingleEvent>> with SelectedEventsRef {
  _SelectedEventsProviderElement(super.provider);

  @override
  List<SingleEvent> get initialEvents =>
      (origin as SelectedEventsProvider).initialEvents;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
