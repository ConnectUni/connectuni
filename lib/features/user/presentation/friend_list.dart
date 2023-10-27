import 'package:connectuni/features/user/domain/user_list.dart';
import 'package:connectuni/features/user/presentation/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/user_providers.dart';
import '../domain/user.dart';

class FriendsList extends ConsumerStatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _FriendsListState();
}

class _FriendsListState extends ConsumerState<FriendsList> {
  @override
  Widget build(BuildContext context) {
    final UserList userList = ref.read(userDBProvider);
    final User currentUser =
        userList.getUserByID(ref.read(currentUserProvider));
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
            Padding(
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
            ...currentUser.friends.map((user) => UserCardWidget(user: user)),
          ],
        ),
      ),
    );
  }
}