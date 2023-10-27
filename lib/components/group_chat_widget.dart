import 'package:connectuni/components/group_card_view.dart';
import 'package:connectuni/screens/group_chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/group.dart';
import '../model/group_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// GroupChatWidget is a widget that displays the group chat.
/// It is a clickable widget that takes the user to the group chat page.

class GroupChatWidget extends ConsumerStatefulWidget {
  String id;

  GroupChatWidget({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<GroupChatWidget> createState() => _GroupChatWidgetState();
}

class _GroupChatWidgetState extends ConsumerState<GroupChatWidget> {
  @override
  Widget build(BuildContext context) {
    final GroupList groupsDB = ref.watch(groupsDBProvider);
    Group groupData = groupsDB.getGroupById(widget.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => GroupChatScreen(id: groupData.groupID)),
        );
      },
      child: GroupCardView(id: groupData.groupID),
    );
  }
}
