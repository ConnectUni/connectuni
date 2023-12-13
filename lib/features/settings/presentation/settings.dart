import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/chat/domain/chat_collection.dart';
import 'package:connectuni/features/chat/presentation/edit_chat_controller.dart';
import 'package:connectuni/features/event/domain/event_collection.dart';
import 'package:connectuni/features/event/presentation/edit_event_controller.dart';
import 'package:connectuni/features/group/domain/group_collection.dart';
import 'package:connectuni/features/group/presentation/edit_group_controller.dart';
import 'package:connectuni/features/message/domain/message_collection.dart';
import 'package:connectuni/features/message/presentation/edit_message_controller.dart';
import 'package:connectuni/features/notification/domain/notification_collection.dart';
import 'package:connectuni/features/notification/presentation/edit_notification_controller.dart';
import 'package:connectuni/features/settings/data/settings_db.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';
import 'package:connectuni/features/user/presentation/edit_user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/presentation/signin_view.dart';
import '../../chat/domain/chat.dart';
import '../../cu_error.dart';
import '../../cu_loading.dart';
import '../../event/domain/event.dart';
import '../../group/domain/group.dart';
import '../../message/domain/message.dart';
import '../../notification/domain/notification.dart';
import '../../user/domain/user.dart';


/// Settings page that allows the user to changes their preferences.

class Settings extends ConsumerStatefulWidget {
  const Settings({
    super.key,
  });

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

void updateThemeMode(ThemeMode? newThemeMode, WidgetRef ref) {
  if (newThemeMode == null) return;
  if (newThemeMode == ref.read(currentThemeModeProvider)) return;
  ref.read(currentThemeModeProvider.notifier).setThemeMode(newThemeMode);
}

class _SettingsState extends ConsumerState<Settings> {

  @override
  Widget build(BuildContext context) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    ref.watch(currentThemeModeProvider);
    return asyncValue.when(
        data: (allData) =>
            _build(
                context: context,
                users: allData.users,
                groups: allData.groups,
                events: allData.events,
                chats: allData.chats,
                notifications: allData.notifications,
                messages: allData.messages,
                currentUser: allData.currentUser,
                ref: ref
            ),
        loading: () => const CULoading(),
        error: (e, st) => CUError(e.toString(), st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required List<User> users,
    required List<Group> groups,
    required List<SingleEvent> events,
    required List<Chat> chats,
    required List<Notification> notifications,
    required List<Message> messages,
    required User currentUser,
    required WidgetRef ref,
  }) {
    UserCollection userCollection = UserCollection(users);
    GroupCollection groupCollection = GroupCollection(groups);
    EventCollection eventCollection = EventCollection(events);
    ChatCollection chatCollection = ChatCollection(chats);
    NotificationCollection notificationCollection = NotificationCollection(notifications);
    MessageCollection messageCollection = MessageCollection(messages);
    List<User> associatedUsers = userCollection.getAssociatedUser(currentUser);
    List<Group> usersGroups = groupCollection.getUsersGroups(currentUser.uid);
    List<SingleEvent> usersEvents = eventCollection.getUsersEvents(currentUser.uid);
    List<Chat> usersChats = chatCollection.getUsersChats(currentUser.uid);
    List<Notification> usersNotifications = notificationCollection.getNotifications(currentUser);
    List<Message> usersMessages = messageCollection.getUsersMessages(currentUser.uid);

    void deleteCurrentUser() {
      for (final user in associatedUsers) {
        if (user.friends.contains(currentUser.uid)) {
          user.friends.remove(currentUser.uid);
        }
        if (user.sentFriendRequests.contains(currentUser.uid)) {
          user.sentFriendRequests.remove(currentUser.uid);
        }
        if (user.receivedFriendRequests.contains(currentUser.uid)) {
          user.receivedFriendRequests.remove(currentUser.uid);
        }
        ref.read(editUserControllerProvider.notifier).updateUser(user: user, onSuccess: () {});
      }
      for(final group in usersGroups) {
        group.userIDs.remove(currentUser.uid);
        if (group.owner == currentUser.uid && group.userIDs.isNotEmpty) {
          group.owner = group.userIDs.first;
          ref.read(editGroupControllerProvider.notifier).updateGroup(group: group, onSuccess: () {});
        } else {
          Chat groupChat = chatCollection.getChatByGroupID(group.groupID);
          ref.read(editChatControllerProvider.notifier).deleteChat(chat: groupChat, onSuccess: () {});
          ref.read(editGroupControllerProvider.notifier).deleteGroup(group: group, onSuccess: () {});
        }
      }
      for (final event in usersEvents) {
        event.userIDs.remove(currentUser.uid);
        ref.read(editEventControllerProvider.notifier).updateEvent(event: event, onSuccess: () {});
      }
      for (final chat in usersChats) {
        chat.userIDs.remove(currentUser.uid);
        chat.messageIDs.removeWhere((messageID) => usersMessages.any((message) => message.messageId == messageID));
        if (chat.groupID == null) {
          ref.read(editChatControllerProvider.notifier).deleteChat(chat: chat, onSuccess: () {});
        } else {
          ref.read(editChatControllerProvider.notifier).updateChat(chat: chat, onSuccess: () {});
        }
      }
      for (final message in usersMessages) {
        ref.read(editMessageControllerProvider.notifier).deleteMessage(message: message, onSuccess: () {});
      }
      for (final notification in usersNotifications) {
        ref.read(editNotificationControllerProvider.notifier).deleteNotification(notification: notification, onSuccess: () {});
      }
      ref.read(editUserControllerProvider.notifier).deleteUser(user: currentUser, onSuccess: () {});
      FirebaseAuth.instance.currentUser?.delete();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Privacy'),
      ),
      body: ListView(
        children: [
          //TODO: Implement functionality and make cards interactive rather than simply visual.
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: const Icon(Icons.arrow_downward),
              title: const Text("Settings",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.notifications_active_outlined,),
              tileColor: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          ListTile(
            leading: Switch(
              value: ref.watch(currentThemeModeProvider) == ThemeMode.dark,
              onChanged: (value) {
                updateThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light, ref);
              },
            ),
            title: const Text("Dark Mode"),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: const Center(
                  child: Text("Change Password",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              tileColor: Theme.of(context).colorScheme.error,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('You are deleting your account. Are you sure?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(context, SignInView.routeName, (route) => false);
                            deleteCurrentUser();
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.error),
              ),
              child: Text('Delete Account'),
            ),
          ),
          SizedBox(
            height: 75.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: () => {
                  FirebaseAuth.instance.signOut(),
                  Navigator.pushNamedAndRemoveUntil(context, SignInView.routeName, (route) => false),
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.tertiary),
                ),
                child: Text('Log Out',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    ); //Scaffold
  } //build
} //HomePage
