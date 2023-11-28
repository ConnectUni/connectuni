import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/chat/domain/chat.dart';
import 'package:connectuni/features/chat/domain/chat_collection.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cu_error.dart';
import '../../group/domain/group.dart';
import '../../message/domain/message.dart';
import '../../message/domain/message_collection.dart';
import '../../user/domain/user.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../group/presentation/groupinfo.dart';
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
    required Group group,
    required List<Chat> chats,
    required List<Message> messages,
    required User currentUser,
    required WidgetRef ref
  }) {
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

    // TODO: Decide what to do with how to list messages, and also decide to add timeStamp to messages

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
                groupBy: (message) => message.groupId!,
                groupHeaderBuilder: (Message message) => const SizedBox(),
                itemBuilder: (context, Message message) => MessageWidget(message: message)
            ),
            ),
          Container(
            color: FlexColor.deepBlueLightPrimaryContainer,
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
