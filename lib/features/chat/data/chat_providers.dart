import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/chat.dart';
import 'chat_database.dart';

part 'chat_providers.g.dart';

@riverpod
ChatDatabase chatDatabase(ChatDatabaseRef ref) {
  return ChatDatabase(ref);
}

@riverpod
Stream<List<Chat>> chats(ChatsRef ref) {
  final database = ref.watch(chatDatabaseProvider);
  return database.watchChats();
}
