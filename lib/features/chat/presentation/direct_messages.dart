import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/chat/data/chat_providers.dart';
import 'package:connectuni/features/chat/domain/chat.dart';
import 'package:connectuni/features/chat/presentation/direct_message_widget.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/domain/user.dart';

class DirectMessages extends ConsumerStatefulWidget {
  const DirectMessages({
    super.key
  });

  @override
  ConsumerState createState() => _DirectMessagesState();
}

class _DirectMessagesState extends ConsumerState {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
      data: (allData) =>
          _build(
            context: context,
            users: allData.users,
            currentUser: allData.currentUser,
            ref: ref
          ),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading(),
    );
  }

  Widget _build({
    required BuildContext context,
    required List<User> users,
    required User currentUser,
    required WidgetRef ref
  }) {
    final AsyncValue<List<Chat>> asyncQueriedChats = ref.watch(queriedChatsProvider);
    UserCollection userCollection = UserCollection(users);

    bool isSearchBarFilled() {
      return controller.text.isNotEmpty;
    }

    /// This displays the search bar.
    Widget buildSearchBar() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: isSearchBarFilled() ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  ref.watch(queriedChatsProvider.notifier).filterQuery('');
                }
            ) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.blue),
            )
        ),
        onChanged: (value) { // This updates the page based on the search query
          ref.watch(queriedChatsProvider.notifier).filterQuery(value);
          //showSearchedEvent(value);
        },
      ),
    );

    /// This displays either all the chats or the queried ones.
    Widget showChats(List<Chat> queriedChats) => Expanded(
      child: queriedChats.isEmpty ? const Text('No messages') : ListView.builder(
        itemCount: queriedChats.length,
        itemBuilder: (context, index) {
          return DirectMessageWidget(
            chat: queriedChats[index],
            otherUser: userCollection.getUser(queriedChats[index].userIDs.firstWhere((id) => id != currentUser.uid))
          );
        },
      ),
    );

    /// This listens to the search bar and returns either the queried chats or all the chats.
    Widget buildChats() => asyncQueriedChats.when(
      data: (queriedChats) => showChats(queriedChats),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Direct Messages'),
      ),
      body: Column(
        children: [
          buildSearchBar(),
          buildChats()
        ],
      ),
    );
  }
}
