import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectuni/features/user/domain/user.dart';
import 'package:connectuni/features/message/domain/message_collection.dart';
import 'package:connectuni/features/message/presentation/edit_message_controller.dart';
import 'package:connectuni/features/chat/domain/chat.dart';
import 'package:connectuni/features/chat/presentation/edit_chat_controller.dart';
import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/cu_error.dart';
import '../../message/domain/message.dart';

/// GroupChatWidget is a widget that displays the group chat.
/// It is a clickable widget that takes the user to the group chat page.

class MessageInputWidget extends ConsumerStatefulWidget {
  Chat chat;

  MessageInputWidget({
    super.key,
    required this.chat,
  });

  @override
  ConsumerState<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends ConsumerState<MessageInputWidget> {

  @override
  Widget build(BuildContext context) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
      data: (allData) => _build(
        context: context,
        messages: allData.messages,
        currentUser: allData.currentUser,
        ref: ref,
      ),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading());
  }
  Widget _build({
    required BuildContext context,
    required List<Message> messages,
    required User currentUser,
    required WidgetRef ref
  }) {
    MessageCollection messageCollection = MessageCollection(messages);
    Chat currentChat = widget.chat;

    return Container(
      margin: const EdgeInsets.all(5.0),
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
                        String thisMessageID = messageCollection.getNewID();
                        if (text == "") {
                          return;
                        }
                        final currentMessage = Message(
                          messageId: thisMessageID,
                          senderId: currentUser.uid,
                          groupId: currentChat.groupID,
                          messageContent: text,
                        );
                        ref.read(editMessageControllerProvider.notifier).updateMessage(
                          message: currentMessage,
                          onSuccess: () {}
                        );
                        currentChat.messageIDs.add(thisMessageID);
                        ref.read(editChatControllerProvider.notifier).updateChat(
                          chat: currentChat,
                          onSuccess: () {}
                        );
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
