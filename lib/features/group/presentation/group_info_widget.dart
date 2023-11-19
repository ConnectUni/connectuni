import 'package:connectuni/features/group/presentation/group_card_view.dart';
import 'package:connectuni/features/group/presentation/groupinfo.dart';
import 'package:flutter/cupertino.dart';
import '../domain/group.dart';

/// GroupChatWidget is a widget that displays the group chat.
/// It is a clickable widget that takes the user to the group chat page.

class GroupInfoWidget extends StatefulWidget {
  const GroupInfoWidget({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  State<GroupInfoWidget> createState() => _GroupInfoWidgetState();
}

class _GroupInfoWidgetState extends State<GroupInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => GroupInfo(group: widget.group)),
        );
      },
      child: GroupCardView(group: widget.group),
    );
  }
}
