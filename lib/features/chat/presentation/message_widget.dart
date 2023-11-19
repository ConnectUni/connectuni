import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../message/domain/message.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';

/// GroupChatWidget is a widget that displays the group chat.
/// It is a clickable widget that takes the user to the group chat page.

class MessageWidget extends ConsumerStatefulWidget {
  Message message;

  MessageWidget({
    super.key,
    required this.message,
  });

  @override
  ConsumerState<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends ConsumerState<MessageWidget> {

  @override
  Widget build(BuildContext context) {
    final String currentUserID = ref.watch(currentUserProvider);
    final User textUser = ref.watch(userDBProvider).getUserByID(widget.message.senderId);
    // If message is not from the user.
    if(widget.message.senderId != currentUserID) {
      return
        Column(
          children: [
            Align(
              alignment:Alignment.topLeft,
              child: Text(textUser.displayName),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child:Row(
                  children:[
                    CircleAvatar(
                       radius: 11,
                       backgroundImage: AssetImage(textUser.pfp),
                    ),
                    Card(
                      elevation: 8.0,
                      color: FlexColor.bahamaBlueDarkPrimary,
                      child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(widget.message.messageContent, style: const TextStyle(color: Colors.white)),
                      ),
              )]
            ),
            ),
          ],
        );
    } else { // If message is from the user.
      return
        Align(
            alignment: Alignment.centerRight,
            child: Card(
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(widget.message.messageContent),
            ),
          ),
      );
    }
  }
}
