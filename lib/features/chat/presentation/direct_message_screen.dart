import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/chat/domain/chat.dart';
import 'package:connectuni/features/chat/domain/chat_collection.dart';
import 'package:connectuni/features/chat/presentation/direct_message_info.dart';
import 'package:connectuni/features/chat/presentation/edit_chat_controller.dart';
import 'package:connectuni/features/chat/presentation/message_input_widget.dart';
import 'package:connectuni/features/chat/presentation/message_widget.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/message/domain/message.dart';
import 'package:connectuni/features/message/domain/message_collection.dart';
import 'package:connectuni/features/user/domain/user.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectMessageScreen extends ConsumerStatefulWidget {
  const DirectMessageScreen({
    super.key,
    this.chat,
    required this.otherUser,
  });

  final Chat? chat;
  final User otherUser;

  @override
  ConsumerState<DirectMessageScreen> createState() => _DirectMessageScreenState();
}

class _DirectMessageScreenState extends ConsumerState<DirectMessageScreen> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);

    return asyncValue.when(
      data: (allData) => _build(
        context: context,
        currentUser: allData.currentUser,
        otherUser: widget.otherUser,
        chats: allData.chats,
        messages: allData.messages,
        ref: ref,
        chat: widget.chat,
      ),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading(),
    );
  }

  Widget _build({
    required BuildContext context,
    required User currentUser,
    required User otherUser,
    required List<Chat> chats,
    required List<Message> messages,
    required WidgetRef ref,
    Chat? chat,
  }) {
    MessageCollection messageCollection = MessageCollection(messages);
    ChatCollection chatCollection = ChatCollection(chats);

    Chat createDirectMessageChat(String currentUserID, String otherUserID) {
      Chat chat = Chat(
        chatID: chatCollection.getNewID(),
        groupID: null,
        userIDs: [currentUserID, otherUserID],
        messageIDs: [],
      );
      ref.read(editChatControllerProvider.notifier).updateChat(chat: chat, onSuccess: () {});

      return chat;
    }

    chat ??= chatCollection.directMessageExists(currentUser.uid, otherUser.uid)
        ? chatCollection.getDirectMessageChat(currentUser.uid, otherUser.uid)
        : createDirectMessageChat(currentUser.uid, otherUser.uid);

    List<Message> currentMessages = messageCollection.getMessages(chat.messageIDs);

    AppBar buildAppBar() => AppBar(
      title: Text(otherUser.displayName),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DirectMessageInfo(chat: chat!, otherUser: otherUser)));
          },
          icon: const Icon(Icons.info),
        )
      ],
    );

    Widget buildMessages() => Column(
      children: [
        currentMessages.isEmpty
            ? const Expanded(child: Text('No Messages'))
            : Expanded(
          child: ListView.builder(
            itemCount: currentMessages.length,
            itemBuilder: (context, index) {
              return MessageWidget(message: currentMessages[index]);
            },
          ),
        ),
        Container(
          color: FlexColor.deepBlueLightPrimaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MessageInputWidget(chat: chat!),
          ),
        )
      ],
    );

    return Scaffold(
      appBar: buildAppBar(),
      body: buildMessages(),
    );
  }
}
