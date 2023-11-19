import 'package:connectuni/features/group/presentation/group_card_view.dart';
import 'package:connectuni/features/chat/presentation/group_chat_screen.dart';
import 'package:flutter/cupertino.dart';
import '../domain/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// GroupChatWidget is a widget that displays the group chat.
/// It is a clickable widget that takes the user to the group chat page.

class GroupChatWidget extends ConsumerStatefulWidget {
  const GroupChatWidget({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  ConsumerState<GroupChatWidget> createState() => _GroupChatWidgetState();
}

class _GroupChatWidgetState extends ConsumerState<GroupChatWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => GroupChatScreen(group: widget.group)),
        );
      },
      child: GroupCardView(group: widget.group),
    );
  }
}
