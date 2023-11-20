import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/chat/domain/chat.dart';
import 'package:connectuni/features/chat/domain/chat_collection.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';
import 'package:connectuni/features/user/presentation/other_user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cu_error.dart';
import '../../group/domain/group.dart';
import '../../message/domain/message.dart';
import '../../message/domain/message_collection.dart';
import '../../user/domain/user.dart';
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
import 'message_input_widget.dart';
import 'message_widget.dart';

class GroupChatScreen extends ConsumerStatefulWidget {
  const GroupChatScreen({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  ConsumerState<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends ConsumerState<GroupChatScreen> {


  @override
  Widget build(BuildContext context) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
      data: (allData) =>
          _build(
            context: context,
            users: allData.users,
            group: widget.group,
            chats: allData.chats,
            messages: allData.messages,
            currentUser: allData.currentUser,
            ref: ref,
          ),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<User> users,
    required Group group,
    required List<Chat> chats,
    required List<Message> messages,
    required User currentUser,
    required WidgetRef ref
  }) {
    UserCollection userCollection = UserCollection(users);
    ChatCollection chatCollection = ChatCollection(chats);
    MessageCollection messageCollection = MessageCollection(messages);

    Chat currentChat = chatCollection.getChat(group.chatID);

    List<Message> thisMessages = chatCollection.getMessagesInChat(messageCollection, currentChat.chatID);

    /// This displays the appbar.
    AppBar buildAppBar() => AppBar(
      title: Text("${group.groupName} | ${group.owner}"),
      actions: [
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => GroupInfo(group: group)),
            );
          },
        ),
      ],
    );

    /// This displays the messages.
    Widget showMessages() => Column(
        children: [
          if(thisMessages.isEmpty)
            const Expanded(child: Center(child: Text("No messages yet. Send one!")))
          else
            Expanded(child:
            GroupedListView<Message, String>(
                reverse: true,
                order: GroupedListOrder.DESC,
                padding: const EdgeInsets.all(8),
                elements: thisMessages,
                groupBy: (element) => element.groupId,
                groupHeaderBuilder: (Message message) => const SizedBox(),
                itemBuilder: (context, Message message) => Align(
                  alignment: message.senderId == currentUserID
                      ? Alignment.centerRight
                      : Alignment.centerLeft
                  ,
                  child: MessageWidget(message: message),
                )
            ),
            ),
          Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MessageInputWidget(chat: currentChat),
            ),
          ),
        ]
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(),
      body: Stack(children: <Widget>[
        showMessages(),
      ]),
    );
  }
}
