import 'package:connectuni/features/group/presentation/group_card_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/group_providers.dart';
import '../domain/group.dart';
import '../domain/group_list.dart';
import 'package:connectuni/screens/groups_screen/groupinfo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// GroupChatWidget is a widget that displays the group chat.
/// It is a clickable widget that takes the user to the group chat page.

class GroupInfoWidget extends ConsumerStatefulWidget {
  String id;

  GroupInfoWidget({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<GroupInfoWidget> createState() => _GroupInfoWidgetState();
}

class _GroupInfoWidgetState extends ConsumerState<GroupInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final GroupList groupsDB = ref.watch(groupsDBProvider);
    Group groupData = groupsDB.getGroupById(widget.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => GroupInfo(id: groupData.groupID)),
        );
      },
      child: GroupCardView(id: groupData.groupID),
    );
  }
}
