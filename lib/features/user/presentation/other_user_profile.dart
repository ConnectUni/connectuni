import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../group/data/group_providers.dart';
import '../../group/domain/group_list.dart';
import '../data/user_providers.dart';
import '../domain/user.dart';
import '../domain/user_list.dart';

class OtherUserProfile extends ConsumerWidget {
  const OtherUserProfile({Key? key, required this.user}) : super(key: key);
  final User user;

  bool isFriend(User user, WidgetRef ref) {
    final UserList userList = ref.read(userDBProvider);
    final User currentUser =
        userList.getUserByID(ref.read(currentUserProvider));
    if (currentUser.friends.contains(user)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = user.uid;
    final UserList usersDB = ref.read(userDBProvider);
    User thisUser = usersDB.getUserByID(uid);
    final User currentUser = usersDB.getUserByID(ref.read(currentUserProvider));
    final GroupList groupsDB = ref.watch(groupsDBProvider);

    bool memberOfGroup(String groupId) {
      if (currentUser.getGroupIDs().contains(groupId)) {
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
                // TODO Add functionality to message user
              },
            ),
            isFriend(user, ref)
                ? IconButton(
                    onPressed: () {
                      currentUser.friends.remove(user);
                    },
                    icon: const Icon(
                      Icons.person_remove,
                      semanticLabel: 'remove friend',
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      currentUser.friends.remove(user);
                    },
                    icon: const Icon(
                      Icons.person_add,
                      semanticLabel: 'add friend',
                    ))
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Column(children: [
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
              const Divider(
                height: 7,
                thickness: 2,
                indent: 20,
                endIndent: 20,
                color: Colors.black,
              ),
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
                      Column(children: [
                        ...currentUser.interests.map((interest) => Padding(
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
                                tileColor: Colors.lightBlue,
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
              Container(
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
                        ...groupsDB.getGroupsByUser(user.uid).map(
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
                                              "${group.semYear} | ${group.getOwner()}"),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 2.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "${group.userIDs.length} people"),
                                        )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: memberOfGroup(group.getGroupID())
                                          ? Align(
                                              alignment: Alignment.bottomRight,
                                              child: TextButton(
                                                onPressed: () {
                                                  ///Remove the user from the group's database
                                                  group.removeUserId(
                                                      currentUser.uid);
                                                  ref.refresh(userDBProvider);
                                                  ref.refresh(groupsDBProvider);
                                                  ref.refresh(
                                                      currentUserProvider);

                                                  ///Modal notification that they left the group
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        buildPopupDialog(
                                                            context),
                                                  );
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Colors.redAccent),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                ),
                                                child: const Text("LEAVE"),
                                              ),
                                            )
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: TextButton(
                                                  onPressed: () {
                                                    group.addUserId(user.uid);
                                                    ref.refresh(userDBProvider);
                                                    ref.refresh(
                                                        groupsDBProvider);
                                                    ref.refresh(
                                                        currentUserProvider);
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.green),
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.white),
                                                  ),
                                                  child: const Text("JOIN")),
                                            ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ],
        ));
  }
}
