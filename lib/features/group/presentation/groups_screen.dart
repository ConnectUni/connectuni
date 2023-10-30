import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectuni/features/group/presentation/group_chat_widget.dart';
import 'package:flutter/material.dart';
import '../domain/group_list.dart';
import '../../user/domain/user_list.dart';
import '../../chat/presentation/chatpage.dart';

class GroupsScreen extends ConsumerStatefulWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends ConsumerState<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    final GroupList groupsDB = ref.watch(groupsDBProvider);
    final String userId = ref.watch(currentUserProvider);
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
              .getGroupsByUser(userId)
              .map((gName) => GroupChatWidget(id: gName.groupID)),
          const Center(
            child:
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.grey,
                  size: 40.0,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
