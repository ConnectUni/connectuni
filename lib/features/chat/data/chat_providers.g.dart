// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatDatabaseHash() => r'967b230ef0aaf3f67327c572bee467d74312d1bd';

/// See also [chatDatabase].
@ProviderFor(chatDatabase)
final chatDatabaseProvider = AutoDisposeProvider<ChatDatabase>.internal(
  chatDatabase,
  name: r'chatDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatDatabaseRef = AutoDisposeProviderRef<ChatDatabase>;
String _$chatsHash() => r'a73e7a25555ac52e075b82122e027cc9828205cd';

/// See also [chats].
@ProviderFor(chats)
final chatsProvider = AutoDisposeStreamProvider<List<Chat>>.internal(
  chats,
  name: r'chatsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatsRef = AutoDisposeStreamProviderRef<List<Chat>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
