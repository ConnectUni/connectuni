import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/notification/domain/notification.dart';
import 'package:connectuni/features/notification/presentation/edit_notification_controller.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';
import 'package:connectuni/features/user/presentation/edit_user_controller.dart';
import 'package:connectuni/features/user/presentation/other_user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart' hide Notification;

import '../../user/domain/user.dart';

/// On future updates, add the different possible notifications
/// Current support notifications: friend requests

class NotificationWidget extends ConsumerWidget {
  NotificationWidget({
    super.key,
    required this.notification,
    });

  Notification notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
      data: (allData) =>
          _build(
            context: context,
            users: allData.users,
            currentUser: allData.currentUser,
            ref: ref
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

    void updateFriends(User requestingUser) {
      ref.read(editUserControllerProvider.notifier).updateUser(
        user: currentUser,
        onSuccess: () {}
      );
      ref.read(editUserControllerProvider.notifier).updateUser(
          user: requestingUser,
          onSuccess: () {}
      );
      ref.read(editNotificationControllerProvider.notifier).deleteNotification(
        notification: notification,
        onSuccess: () {}
      );
    }

    Widget buildFriendRequest() {
      User requestingUser = userCollection.getUser(notification.senderID!);

      return ListTile(
        title: Text(notification.title),
        subtitle: const Text('Do you accept?'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  currentUser.receivedFriendRequests.remove(requestingUser.uid);
                  requestingUser.sentFriendRequests.remove(currentUser.uid);
                  currentUser.friends.add(requestingUser.uid);
                  requestingUser.friends.add(currentUser.uid);
                  currentUser.notificationIDs.remove(notification.notificationID);
                  updateFriends(requestingUser);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OtherUserProfile(user: requestingUser)),
                  );
                }
            ),
            IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  currentUser.receivedFriendRequests.remove(requestingUser.uid);
                  requestingUser.sentFriendRequests.remove(currentUser.uid);
                  currentUser.notificationIDs.remove(notification.notificationID);
                  updateFriends(requestingUser);
                }
            )
          ],
        ),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(requestingUser.pfp),
        ),
      );
    }

    Widget buildEventNotif() => ListTile(
      title: Text(notification.title),
    );

    Widget buildNotification(String type) {
      if (type == 'friend-request') {
        return buildFriendRequest();
      }
      if (type == '') {
        return buildEventNotif();
      }
      return const ListTile(
        title: Text('There was an error building this notification'),
      );
    }

    return buildNotification(notification.type);
  }
}
