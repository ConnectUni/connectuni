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
String _$directMessagesHash() => r'41ba8ba575c7b02b3c5a1a69c007f34cc05b8578';

/// See also [directMessages].
@ProviderFor(directMessages)
final directMessagesProvider = AutoDisposeFutureProvider<List<Chat>>.internal(
  directMessages,
  name: r'directMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$directMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DirectMessagesRef = AutoDisposeFutureProviderRef<List<Chat>>;
String _$queriedChatsHash() => r'e462fe691d55e2828978639e3dea83ed4e47e524';

/// See also [QueriedChats].
@ProviderFor(QueriedChats)
final queriedChatsProvider =
    AutoDisposeAsyncNotifierProvider<QueriedChats, List<Chat>>.internal(
  QueriedChats.new,
  name: r'queriedChatsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$queriedChatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$QueriedChats = AutoDisposeAsyncNotifier<List<Chat>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
