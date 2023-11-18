import 'package:connectuni/features/user/data/user_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../group/data/group_providers.dart';
import '../../group/domain/group.dart';
import '../../group/domain/group_list.dart';
import '../../message/data/message_providers.dart';
import '../../message/domain/message.dart';
import '../../message/domain/message_list.dart';
import '../../group/presentation/groupinfo.dart';
import '../data/chat_providers.dart';
import '../domain/chat.dart';
import '../domain/chat_list.dart';

class GroupChatScreen extends ConsumerStatefulWidget {
  final String id;

  const GroupChatScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends ConsumerState<GroupChatScreen> {


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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("${groupData.groupName} | ${groupData.owner}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => GroupInfo(id: widget.id)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child:
            GroupedListView<Message, String>(
              reverse: true,
              order: GroupedListOrder.DESC,
              padding: const EdgeInsets.all(8),
              elements: thisMessages,
              groupBy: (element) => element.groupId,
              groupHeaderBuilder: (Message message) => const SizedBox(
                height: 50,
                child: Card(
                  elevation: 8.0,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Welcome to the chat!"),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.senderId == currentUserID
                  ? Alignment.centerRight
                    : Alignment.centerLeft
                ,

                child: Card(
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(message.messageContent),
                  ),
                ),
              )
            ),
          ),
          Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Type your message here...',
              ),
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
            ),
            ),
          ),
        ]
      ),
    );
  }
}
