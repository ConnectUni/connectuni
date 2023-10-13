import 'package:connectuni/components/user_card_widget.dart';
import 'package:connectuni/model/userList.dart';
import 'package:flutter/material.dart';

import '../components/user_card_search.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  State createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
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
            ...usersDB
                .getUsers()
                .map((uName) => UserCardWidget(id: uName.uid)),
          ],
        ),
      ),
    );
  }
}
