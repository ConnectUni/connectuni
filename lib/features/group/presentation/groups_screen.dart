import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/chat/presentation/direct_messages.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/group/domain/group_collection.dart';
import 'package:connectuni/features/notification/presentation/notification_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectuni/features/chat/presentation/group_chat_widget.dart';
import 'package:flutter/material.dart';
import '../../cu_error.dart';
import '../domain/group.dart';
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DirectMessages()));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_active_outlined,
              semanticLabel: 'notifications',
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationView()));
            },
          ),
        ],
      ),
      body:
      ListView(
        children: [
          ...groupCollection
              .getUsersGroups(currentUserID)
              .map((group) => GroupChatWidget(group: group)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddGroup()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
