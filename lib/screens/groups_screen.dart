import 'package:flutter/material.dart';

import 'package:connectuni/model/group.dart';
import 'package:connectuni/model/group_card_view.dart';
import 'package:connectuni/screens/chatpage.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  State createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Groups'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.email_outlined,
              semanticLabel: 'messages',
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ChatPage();
              }));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_active_outlined,
              semanticLabel: 'notifications',
            ),
            onPressed: () {
              print('Go to Notifications page');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          //TODO: Implement functionality and make cards interactive rather than simply visual.
          ...groupsDB
              .getGroups()
              .map((gName) => GroupCardView(name: gName.groupName)),
          const Center(
            //TODO: Implement functionality and change from ICON to Button
            child: Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
              size: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}
