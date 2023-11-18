import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/group/domain/group_collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectuni/features/group/presentation/group_chat_widget.dart';
import 'package:flutter/material.dart';
import '../../cu_error.dart';
import '../domain/group.dart';
import '../../chat/presentation/chatpage.dart';
import 'add_group.dart';

class GroupsScreen extends ConsumerStatefulWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends ConsumerState<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
      data: (allData) => _build(
        context: context,
        groups: allData.groups,
        currentUserID: allData.currentUser.uid,
        ref: ref,
      ),
      error: (e,st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<Group> groups,
    required String currentUserID,
    required WidgetRef ref
  }) {
    GroupCollection groupCollection = GroupCollection(groups);

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
              // TODO: implement notifications page? 11/17/2023
              print('Go to Notifications page');
            },
          ),
        ],
      ),
      body:
      ListView(
        children: [
          ...groupCollection
              .getUsersGroups(currentUserID)
              .map((group) => GroupChatWidget(group: group,)),
          Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddGroup()));
                    },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.grey,
                    size: 40.0,
                  ),
                ),
              )
          ),
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
