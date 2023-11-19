// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userDatabaseHash() => r'3256f4789bc577740b97941417a09b6e35030584';

/// See also [userDatabase].
@ProviderFor(userDatabase)
final userDatabaseProvider = AutoDisposeProvider<UserDatabase>.internal(
  userDatabase,
  name: r'userDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserDatabaseRef = AutoDisposeProviderRef<UserDatabase>;
String _$usersHash() => r'e177995bef6c9c01d40aa26d43154058b842be28';

/// See also [users].
@ProviderFor(users)
final usersProvider = AutoDisposeStreamProvider<List<User>>.internal(
  users,
  name: r'usersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersRef = AutoDisposeStreamProviderRef<List<User>>;
String _$currentUserIDHash() => r'fcc1b736638289871b82e61abfd9a5984bede617';

/// See also [currentUserID].
@ProviderFor(currentUserID)
final currentUserIDProvider = AutoDisposeProvider<String>.internal(
  currentUserID,
  name: r'currentUserIDProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIDHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserIDRef = AutoDisposeProviderRef<String>;
String _$currentUserHash() => r'df977552e228aa614e5f1ba325dd0b22a113a13e';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeFutureProvider<User>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserRef = AutoDisposeFutureProviderRef<User>;
String _$filteredUsersHash() => r'8e73e009f96661824edb9bac58946e2f33d35d6c';

/// See also [FilteredUsers].
@ProviderFor(FilteredUsers)
final filteredUsersProvider =
    AutoDisposeAsyncNotifierProvider<FilteredUsers, List<User>>.internal(
  FilteredUsers.new,
  name: r'filteredUsersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FilteredUsers = AutoDisposeAsyncNotifier<List<User>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
