import 'package:connectuni/features/user/presentation/other_user_profile.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';
import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/cu_error.dart';

import '../../message/domain/message.dart';
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
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
        data: (allData) =>
            _build(
              context: context,
              users: allData.users,
              currentUser: allData.currentUser,
              ref: ref,
            ),
        error: (e, st) => CUError(e.toString(), st.toString()),
        loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<User> users,
    required User currentUser,
    required WidgetRef ref
  }) {
    UserCollection userCollection = UserCollection(users);
    Message message = widget.message;


    // If message is not from the user.
    if(message.senderId != currentUser.uid) {
      final User textUser = userCollection.getUser(message.senderId);
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OtherUserProfile(user: textUser)),
                        );
                      },
                      child: CircleAvatar(
                         radius: 15,
                         backgroundImage: AssetImage(textUser.pfp),
                      ),
                    ),
                    Card(
                      elevation: 8.0,
                      color: FlexColor.bahamaBlueDarkPrimary,
                      child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(message.messageContent, style: const TextStyle(color: Colors.white)),
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
                child: Text(message.messageContent),
            ),
          ),
      );
    }
  }
}
