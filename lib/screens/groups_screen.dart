import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectuni/components/group_chat_widget.dart';
import 'package:flutter/material.dart';
import '../model/group_list.dart';
import '/screens/chatpage.dart';

class GroupsScreen extends ConsumerStatefulWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends ConsumerState<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    final GroupList groupsDB = ref.watch(groupsDBProvider);
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
              .getAllGroups()
              .map((gName) => GroupChatWidget(id: gName.groupID)),
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
