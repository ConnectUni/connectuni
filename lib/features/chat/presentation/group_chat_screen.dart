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
import '../../group/presentation/groupinfo.dart';

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

    String currentUID = currentUser.uid;
    Chat currentChat = chatCollection.getChat(group.chatID);
    List<Message> messageData = messageCollection.getMessages(currentChat.messageIDs);
    List<User> groupMembers = chatCollection.getUsersInChats(userCollection, currentChat.chatID);

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
    Widget showMessages() => ListView.builder(
      itemCount: messageData.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(
              left: 14, right: 14, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment:
            (messageData.elementAt(index).senderId == currentUID
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start),
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                    (messageData.elementAt(index).senderId == currentUID
                        ? Colors.blue[200]
                        : Colors.grey.shade200),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    messageData.elementAt(index).messageContent,
                    style: const TextStyle(fontSize: 15),
                  )),
              Text(
                groupMembers
                    .firstWhere((user) =>
                user.uid == messageData.elementAt(index).senderId)
                    .displayName,
                style: const TextStyle(fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => OtherUserProfile(user: groupMembers
                            .firstWhere((user) =>
                        user.uid == messageData.elementAt(index).senderId))
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(groupMembers
                      .firstWhere((user) =>
                  user.uid == messageData.elementAt(index).senderId)
                      .pfp),
                  maxRadius: 20,
                ),
              )
            ],
          ),
        );
      },
    );

    /// This displays the input field.
    Widget buildInputField() => Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        height: 60,
        width: double.infinity,
        color: Colors.grey,
        child: Row(children: <Widget>[
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Write message...",
                hintStyle: const TextStyle(color: Colors.black54),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          FloatingActionButton(
            onPressed: () {},
            elevation: 0,
            child: const Icon(Icons.send, color: Colors.white, size: 18),
          ),
        ]),
      ),
    );

    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(children: <Widget>[
        showMessages(),
        buildInputField(),
      ]),
    );
  }
}
