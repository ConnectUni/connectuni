import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';
import 'package:connectuni/features/user/presentation/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/user.dart';


class FriendsList extends ConsumerStatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _FriendsListState();
}

class _FriendsListState extends ConsumerState<FriendsList> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
        data: (allData) => _build(
            context: context,
            users: allData.users,
            currentUser: allData.currentUser,
            ref: ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stacktrace) =>
            Text('Error: $error, Stacktrace: $stacktrace'));
  }

  Widget _build({
    required BuildContext context,
    required List<User> users,
    required User currentUser,
    required WidgetRef ref}) {
    UserCollection userCollection = UserCollection(users);

    return Scaffold(
      appBar: AppBar(title: const Text('Friends List'), actions: <Widget>[
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              semanticLabel: 'Add more friends',
            )),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding( // TODO Implement Search functionality
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  hintText: 'Search for friends',
                  onTap: () {},
                  onChanged: (_) {},
                  leading: const Icon(Icons.search),
                );
              }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String friend = 'friend $index';
                  return ListTile(
                    title: Text(friend),
                    onTap: () {
                      setState(() {
                        controller.closeView(friend);
                      });
                    },
                  );
                });
              }),
            ),
            ...userCollection.getFriends(currentUser).map((user) => UserCardWidget(user: user)),
          ],
        ),
      ),
    );
  }
}
