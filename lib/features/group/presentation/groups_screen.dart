import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectuni/features/chat/presentation/group_chat_widget.dart';
import 'package:flutter/material.dart';
import '../../user/data/user_providers.dart';
import '../data/group_providers.dart';
import '../domain/group_list.dart';

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
    late PageController _pageController;
    _pageController = PageController();
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
              //TODO: Go to Group Chats Page with Individuals
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
      body:
      ListView(
        children: [
          if(groupsDB.getGroupsByUser(userId).isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text(
                    'You are not in any groups yet.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Join or add a group to get started!',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]
              )
            ),
          ),
          if(groupsDB.getGroupsByUser(userId).isNotEmpty)
          ...groupsDB
              .getGroupsByUser(userId)
              .map((gName) => GroupChatWidget(id: gName.groupID)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_group');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
