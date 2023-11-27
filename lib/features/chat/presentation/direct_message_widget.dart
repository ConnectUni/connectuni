import 'package:connectuni/features/chat/domain/chat.dart';
import 'package:connectuni/features/chat/presentation/direct_message_screen.dart';
import 'package:flutter/material.dart';

import '../../user/domain/user.dart';

class DirectMessageWidget extends StatelessWidget {
  const DirectMessageWidget({
    super.key,
    required this.chat,
    required this.otherUser
  });
  final Chat chat;
  final User otherUser;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DirectMessageScreen(chat: chat, otherUser: otherUser)));
      },
      title: Text(otherUser.displayName),
      leading: CircleAvatar(
        backgroundImage: AssetImage(otherUser.pfp),
      ),
      subtitle: Text(chat.messageIDs.isNotEmpty ? chat.messageIDs.last : 'No messages yet'),
    );
  }
}
