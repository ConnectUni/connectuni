import 'package:connectuni/features/user/data/user_providers.dart';
import 'package:connectuni/features/user/domain/user.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';
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

@riverpod
Future<List<Chat>> directMessages(DirectMessagesRef ref) async {
  final User currentUser = await ref.watch(currentUserProvider.future);
  final List<Chat> chats = await ref.watch(chatsProvider.future);
  return chats.where((chat) => chat.userIDs.length == 2 && chat.userIDs.contains(currentUser.uid)).toList();
}

@riverpod
class QueriedChats extends _$QueriedChats {
  bool mounted = true;
  User? currentUser;
  List<String> matchingUserIDs = [];
  List<User> users = [];
  List<Chat> chats = [];
  List<Chat> results = [];
  String query = '';

  @override
  FutureOr<List<Chat>> build() async {
    ref.onDispose(() => mounted = false);
    currentUser = await ref.watch(currentUserProvider.future);
    chats = await ref.watch(directMessagesProvider.future);
    users = await ref.watch(usersProvider.future);
    return chats;
  }

  void _updateResults() {
    if (query.isEmpty) {
      results = chats;
    } else {
      matchingUserIDs = users.where((user) => user.displayName.toLowerCase().contains(query.toLowerCase())).map((user) => user.uid).toList();
      results = chats.where((chat) => matchingUserIDs.any((id) => chat.userIDs.contains(id) && id != currentUser?.uid)).toList();
    }
    if (mounted) {
      state = AsyncData(results);
    }
  }
  //           users.where((user) => user.displayName.toLowerCase().contains(query.toLowerCase())).first.uid

  void filterQuery(String input) {
    query = input;
    _updateResults();
  }
}
