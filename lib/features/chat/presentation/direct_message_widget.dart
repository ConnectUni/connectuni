import 'package:connectuni/features/chat/domain/chat.dart';
import 'package:connectuni/features/chat/presentation/direct_message_screen.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/message/data/message_providers.dart';
import 'package:connectuni/features/message/domain/message_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../message/domain/message.dart';
import '../../user/domain/user.dart';

class DirectMessageWidget extends ConsumerWidget {
  const DirectMessageWidget({
    super.key,
    required this.chat,
    required this.otherUser
  });
  final Chat chat;
  final User otherUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue asyncValue = ref.watch(messagesProvider);
    return asyncValue.when(
        data: (messages) =>
            _build(
                context: context,
                messages: messages,
                otherUser: otherUser,
                chat: chat
            ),
        error: (e, st) => CUError(e.toString(), st.toString()),
        loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<Message> messages,
    required User otherUser,
    required Chat chat
  }) {
    MessageCollection messageCollection = MessageCollection(messages);
    String lastMessage = 'No messages yet';
    if (chat.messageIDs.isNotEmpty) {
      lastMessage = messageCollection.getContentFrom(chat.messageIDs.last);
    }

    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DirectMessageScreen(chat: chat, otherUser: otherUser)));
      },
      title: Text(otherUser.displayName),
      leading: CircleAvatar(
        backgroundImage: AssetImage(otherUser.pfp),
      ),
      subtitle: Text(
        lastMessage,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
/*

 */
