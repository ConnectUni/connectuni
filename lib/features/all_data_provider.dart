import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'interest/data/interests.dart';
import 'user/data/user_providers.dart';
import 'user/domain/user.dart';
import 'group/data/group_providers.dart';
import 'group/domain/group.dart';
import 'event/data/event_providers.dart';
import 'event/domain/event.dart';
import 'chat/data/chat_providers.dart';
import 'chat/domain/chat.dart';
import 'message/data/message_providers.dart';
import 'message/domain/message.dart';

part 'all_data_provider.g.dart';

class AllData {
  AllData({
    required this.users,
    required this.filteredUsers,
    required this.groups,
    required this.filteredGroups,
    required this.events,
    required this.chats,
    required this.messages,
    required this.interests,
    required this.currentUser,
  });

  final List<User> users;
  final List<User> filteredUsers;
  final List<Group> groups;
  final List<Group> filteredGroups;
  final List<SingleEvent> events;
  final List<Chat> chats;
  final List<Message> messages;
  final List<String> interests;
  final User currentUser;
}

@riverpod
Future<AllData> allData(AllDataRef ref) async {
  final users = ref.watch(usersProvider.future);
  final filteredUsers = ref.watch(filteredUsersProvider.future);
  final groups = ref.watch(groupsProvider.future);
  final filteredGroups = ref.watch(filteredGroupsProvider.future);
  final events = ref.watch(eventsProvider.future);
  final chats = ref.watch(chatsProvider.future);
  final messages = ref.watch(messagesProvider.future);
  final interests = ref.watch(interestsProvider);
  final currentUser = ref.watch(currentUserProvider.future);
  return AllData(
    users: await users,
    filteredUsers: await filteredUsers,
    groups: await groups,
    filteredGroups: await filteredGroups,
    events: await events,
    chats: await chats,
    messages: await messages,
    interests: interests,
    currentUser: await currentUser,
  );
}
