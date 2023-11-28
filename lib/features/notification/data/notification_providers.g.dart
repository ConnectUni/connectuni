// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationDatabaseHash() =>
    r'8c9fea5f4bd7b887040862593c7c8c516d542522';

/// See also [notificationDatabase].
@ProviderFor(notificationDatabase)
final notificationDatabaseProvider =
    AutoDisposeProvider<NotificationDatabase>.internal(
  notificationDatabase,
  name: r'notificationDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotificationDatabaseRef = AutoDisposeProviderRef<NotificationDatabase>;
String _$notificationsHash() => r'ce6701ae80d09924a5509e1f66d1b9b70b544e4d';

/// See also [notifications].
@ProviderFor(notifications)
final notificationsProvider =
    AutoDisposeStreamProvider<List<Notification>>.internal(
  notifications,
  name: r'notificationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotificationsRef = AutoDisposeStreamProviderRef<List<Notification>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
