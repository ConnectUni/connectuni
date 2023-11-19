import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../group/data/group_providers.dart';
import '../../group/domain/group.dart';
import '../../group/domain/group_list.dart';
import '../../message/data/message_providers.dart';
import '../../message/domain/message.dart';
import '../../message/domain/message_list.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../../user/domain/user_list.dart';
import '../data/chat_providers.dart';
import '../domain/chat.dart';
import '../domain/chat_list.dart';

/// GroupChatWidget is a widget that displays the group chat.
/// It is a clickable widget that takes the user to the group chat page.

class MessageInputWidget extends ConsumerStatefulWidget {
  String id;

  MessageInputWidget({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends ConsumerState<MessageInputWidget> {

  @override
  Widget build(BuildContext context) {
    final GroupList groupsDB = ref.watch(groupsDBProvider);
    final ChatList chatsDB = ref.watch(chatDBProvider);
    final MessageList messageDB = ref.watch(messagesDBProvider);
    final String currentUserID = ref.watch(currentUserProvider);
    Group groupData = groupsDB.getGroupById(widget.id);
    Chat chatData = chatsDB.getChatByGroupId(widget.id);
    List<String> messagesAsString = chatData.messageIDs;
    List<Message> thisMessages = messagesAsString.map((e) => messageDB.getMessageById(e)).toList();
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 5,
                      color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(padding: const EdgeInsets.only(left: 8, right: 8), child: TextField(
                      decoration: const InputDecoration(
                          hintText: "Type Something and Hit Enter...",
                          hintStyle: TextStyle( color:     Colors.blueAccent),
                          border: InputBorder.none),
                      onSubmitted: (text) {
                        int messageIdCounter = messageDB.length() + 1;
                        String thisMessageId;
                        if (messageIdCounter < 10) {
                          thisMessageId = "message-00$messageIdCounter";
                        } else if (messageIdCounter < 100) {
                          thisMessageId = "message-0$messageIdCounter";
                        } else {
                          thisMessageId = "message-$messageIdCounter";
                        }
                        if (text == "") {
                          return;
                        }
                        final currentMessage = Message(
                          messageId: thisMessageId,
                          senderId: currentUserID,
                          groupId: widget.id,
                          messageContent: text,
                        );

                        ref.read(messagesDBProvider).addMessage(currentMessage);
                        ref.read(chatDBProvider).addMessageIdToGroupChat(widget.id, thisMessageId);
                        ref.refresh(chatDBProvider);
                        ref.refresh(messagesDBProvider);
                      },
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}