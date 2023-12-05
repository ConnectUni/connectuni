import 'package:connectuni/features/chat/presentation/direct_message_screen.dart';
import 'package:connectuni/features/notification/domain/notification.dart';
import 'package:connectuni/features/notification/domain/notification_collection.dart';
import 'package:connectuni/features/notification/presentation/edit_notification_controller.dart';
import 'package:connectuni/features/user/presentation/edit_user_controller.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/group/domain/group.dart';
import 'package:connectuni/features/group/domain/group_collection.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../all_data_provider.dart';
import '../../cu_loading.dart';
import '../domain/user.dart';

class OtherUserProfile extends ConsumerWidget {
  const OtherUserProfile({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
              context: context,
              currentUser: allData.currentUser,
              groups: allData.groups,
              notifications: allData.notifications,
              ref: ref,
            ),
        loading: () => const CULoading(),
        error: (e, st) => CUError(e.toString(), st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required User currentUser,
    required List<Group> groups,
    required List<Notification> notifications,
    required WidgetRef ref,
  }) {
    GroupCollection groupCollection = GroupCollection(groups);
    NotificationCollection notificationCollection =
        NotificationCollection(notifications);

    bool isFriend() {
      return currentUser.friends.contains(user.uid);
    }

    bool requestPending() {
      return user.receivedFriendRequests.contains(currentUser.uid);
    }

    void updateUsers(User user1, User user2) {
      ref.read(editUserControllerProvider.notifier).updateUser(
            user: user1,
            onSuccess: () {},
          );
      ref.read(editUserControllerProvider.notifier).updateUser(
            user: user2,
            onSuccess: () {},
          );
    }

    void sendFriendReq(User sendingUser, User receivingUser) {
      Notification newNotif = Notification(
        notificationID: notificationCollection.getNewID(),
        timestamp: DateTime.now(),
        receiverID: receivingUser.uid,
        title: '${sendingUser.displayName} sent you a friend request!',
        type: 'friend-request',
        senderID: sendingUser.uid,
      );
      ref.read(editNotificationControllerProvider.notifier).updateNotification(
            notification: newNotif,
            onSuccess: () {},
          );
      receivingUser.notificationIDs.add(newNotif.notificationID);
      updateUsers(sendingUser, receivingUser);
    }

    void removeFriendReq(User sendingUser, User receivingUser) {
      Notification notif = notificationCollection.getNotificationToFrom(
          receivingUser.uid, sendingUser.uid);
      receivingUser.notificationIDs.remove(notif.notificationID);
      ref.read(editNotificationControllerProvider.notifier).deleteNotification(
            notification: notif,
            onSuccess: () {
              Navigator.pop(context);
            },
          );
      updateUsers(sendingUser, receivingUser);
    }

    bool memberOfGroup(String groupId) {
      if (currentUser.groupIDs.contains(groupId)) {
        return true;
      }
      return false;
    }

    Widget buildPopupDialog(BuildContext context) {
      return AlertDialog(
        title: const Text('Sad to see you leave!'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("You have left the group."),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    }

    /// This displays add/remove friends button
    Widget isFriendIcon() {
      if (isFriend()) {
        return FilledButton(
          onPressed: () {
            Navigator.pop(context);
            currentUser.friends.remove(user.uid);
            user.friends.remove(currentUser.uid);
            updateUsers(currentUser, user);
          },
          child: const Text('Remove Connection :('),
        );
      } else if (requestPending()) {
        return FilledButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Remove friend request? :('),
                  actions: [
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        currentUser.sentFriendRequests.remove(user.uid);
                        user.receivedFriendRequests.remove(currentUser.uid);
                        removeFriendReq(currentUser, user);
                      },
                    ),
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
          },
          child: const Text('Pending Request'),
        );
      } else {
        return FilledButton(
          onPressed: () {
            currentUser.sentFriendRequests.add(user.uid);
            user.receivedFriendRequests.add(currentUser.uid);
            sendFriendReq(currentUser, user);
          },
          child: const Text('Connect with me!'),
        );
      }
    }

    /// This displays the user's information.
    List<Widget> displayInfo = [
      CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(user.pfp),
      ),
      Text(
        user.displayName,
        style: const TextStyle(
          fontSize: 23.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'Major: ${user.major}',
        style: const TextStyle(
          fontSize: 15.0,
        ),
      ),
      Text(
        'Projected Grad: ${user.projectedGraduation}',
        style: const TextStyle(
          fontSize: 15.0,
        ),
      ),
      Text(
        'Status: ${user.status}',
        style: const TextStyle(
          fontSize: 15.0,
        ),
      ),
      Text(
        'Friends: ${user.friends.length}',
        style: const TextStyle(
          fontSize: 15.0,
        ),
      ),
      isFriendIcon(),
      const Divider(
        height: 7,
        thickness: 2,
        indent: 20,
        endIndent: 20,
      )
    ];

    /// This displays the user's interests.
    List<Widget> displayInterests = [
      Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Their Interests",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              if (user.interests.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Center(
                        child: Text("This User has no Interests.",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    textColor: Colors.white,
                    tileColor: Colors.lightBlue,
                  ),
                ),
              Column(children: [
                ...user.interests.map((interest) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Center(
                          child: Text(
                            interest,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        textColor: Colors.white,
                        tileColor: FlexColor.deepBlueLightTertiary,
                      ),
                    )),
              ]),
            ],
          )),
      const Divider(
        height: 7,
        thickness: 2,
        indent: 20,
        endIndent: 20,
        color: Colors.black,
      ),
    ];

    /// This displays the user's groups.
    Widget displayGroups() => Container(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Their Courses:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Column(
                children: [
                  ...groupCollection.getGroups(user.groupIDs).map(
                        (group) => Card(
                          elevation: 8,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(group.groupName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 5.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "${group.semYear} | ${group.owner}"),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 2.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child:
                                        Text("${group.userIDs.length} people"),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: memberOfGroup(group.groupID)
                                      ? Align(
                                          alignment: Alignment.bottomRight,
                                          child: TextButton(
                                            onPressed: () {
                                              /// Remove the user from the group's database.
                                              group.userIDs
                                                  .remove(currentUser.uid);
                                              currentUser.groupIDs
                                                  .remove(group.groupID);
                                              ref.refresh(allDataProvider);

                                              /// Display "You have left the group" modal.
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    buildPopupDialog(context),
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.redAccent),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                            ),
                                            child: const Text('LEAVE'),
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.bottomRight,
                                          child: TextButton(
                                            onPressed: () {
                                              /// Add the user to the group's database.
                                              group.userIDs
                                                  .add(currentUser.uid);
                                              currentUser.groupIDs
                                                  .add(group.groupID);
                                              ref.refresh(allDataProvider);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.green),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                            ),
                                            child: const Text('JOIN'),
                                          ),
                                        )),
                              const SizedBox(height: 10)
                            ],
                          ),
                        ),
                      ),
                ],
              )
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.message,
              semanticLabel: 'message',
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DirectMessageScreen(otherUser: user)));
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Column(
            children: [...displayInfo, ...displayInterests, displayGroups()],
          ),
        ],
      ),
    );
  }
}
/*



 */
