import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/chat/presentation/edit_chat_controller.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/message/domain/message.dart';
import 'package:connectuni/features/message/domain/message_collection.dart';
import 'package:connectuni/features/message/presentation/edit_message_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cu_loading.dart';
import '../../user/domain/user.dart';
import '../domain/chat.dart';

class DirectMessageInfo extends ConsumerWidget {
  const DirectMessageInfo({
    super.key,
    required this.chat,
    required this.otherUser
  });
  final Chat chat;
  final User otherUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
      data: (allData) =>
          _build(
            context: context,
            chat: chat,
            otherUser: otherUser,
            messages: allData.messages,
            ref: ref
          ),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading()
    );
  }

  Widget _build({
    required BuildContext context,
    required Chat chat,
    required User otherUser,
    required List<Message> messages,
    required WidgetRef ref
  }) {
    MessageCollection messageCollection = MessageCollection(messages);
    List<Message> currentMessages = messageCollection.getMessages(chat.messageIDs);

    return Scaffold(
      appBar: AppBar(
        title: Text(otherUser.displayName),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete this chat?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                ref.read(editChatControllerProvider.notifier).deleteChat(
                                    chat: chat,
                                    onSuccess: () {
                                      Navigator.of(context)..pop()..pop()..pop();
                                    }
                                );
                                for (final message in currentMessages) {
                                  ref.read(editMessageControllerProvider.notifier).deleteMessage(
                                      message: message,
                                      onSuccess: () {}
                                  );
                                }
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)
                  ),
                  child: const Text('Delete this chat?'),
                ),
              ),
            ]
          )
        ],
      ),
    );
  }
}
