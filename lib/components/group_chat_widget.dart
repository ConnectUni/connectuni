import 'package:connectuni/components/group_card_view.dart';
import 'package:connectuni/screens/group_chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/group.dart';
import '../model/group_list.dart';

/// GroupChatWidget is a widget that displays the group chat.
/// It is a clickable widget that takes the user to the group chat page.

class GroupChatWidget extends StatefulWidget {
  String id;

  GroupChatWidget({
    super.key,
    required this.id,
  });

  @override
  State<GroupChatWidget> createState() => _GroupChatWidgetState();
}

class _GroupChatWidgetState extends State<GroupChatWidget> {
  @override
  Widget build(BuildContext context) {
    Group groupData = groupsDB.getGroupById(widget.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => GroupChatScreen(id: groupData.groupID)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: GroupCardView(id: groupData.groupID),
      ),
    );
  }
}
