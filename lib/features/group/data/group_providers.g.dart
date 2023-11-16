// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupDatabaseHash() => r'a5692a8b8180925de51192cb4f8a4027bc1cbbec';

/// See also [groupDatabase].
@ProviderFor(groupDatabase)
final groupDatabaseProvider = AutoDisposeProvider<GroupDatabase>.internal(
  groupDatabase,
  name: r'groupDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groupDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GroupDatabaseRef = AutoDisposeProviderRef<GroupDatabase>;
String _$groupsHash() => r'9d5815e9a4e6c9e75f13b93f9ecfe8bf9eb66a11';

/// See also [groups].
@ProviderFor(groups)
final groupsProvider = AutoDisposeStreamProvider<List<Group>>.internal(
  groups,
  name: r'groupsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$groupsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GroupsRef = AutoDisposeStreamProviderRef<List<Group>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
