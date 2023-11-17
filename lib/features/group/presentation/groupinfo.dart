import 'package:connectuni/features/group/presentation/group_member_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectuni/features/group/domain/group.dart';
import '../../home/presentation/home.dart';
import '../../interest/presentation/edit_interests.dart';
import '../../user/data/user_providers.dart';
import '../data/group_providers.dart';
import '../domain/group_list.dart';
import '../../user/domain/user_list.dart';
import 'edit_group.dart';

/// Information page for a specific group that displays the group members as well as a description of the selected group.
/// There is an icon at the upper right-hand corner for more statistic-related properties of the group.

class GroupInfo extends ConsumerStatefulWidget {
  final String id;

  const GroupInfo({
    Key? key,
    required this.id,
  }) : super(key: key);

  ConsumerState<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends ConsumerState<GroupInfo> {
  @override
  Widget build(BuildContext context) {
    final GroupList groupsDB = ref.watch(groupsDBProvider);
    final String currentUser = ref.watch(currentUserProvider);
    Group groupData = groupsDB.getGroupById(widget.id);

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
        leading: const BackButton(),
        title: Text('${groupData.groupName} | ${groupData.owner}'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.badge_outlined,
              semanticLabel: 'Information',
            ),
            onPressed: () {
              print(
                  'Go to Information page'); // 10/20/23: Is this not the information page? do we need this icon?
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          //TODO: Implement functionality and make cards interactive rather than simply visual.
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Members:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(child: Column(
              children: [
                ...groupData
                    .userIDs.map((userId) => TempUsersDB.getUserByID(userId)).toList()
                    .map((user) => GroupMemberWidget(user: user)),
              ],
            ),),
          ),
          const Divider(
            height: 7,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Information:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Text(
              groupData.groupDescription,
              softWrap: true,
            ),
          ),
    const Padding(
      padding: EdgeInsets.only(top: 20, left: 20),
      child: Text(
      'Interests:',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Column(children: [
      ...groupData.interests.map(
        (interest) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
        title: Center(
          child: Text(interest,
           style: const TextStyle(
            fontWeight: FontWeight.bold))),
             textColor: Colors.white,
             tileColor: Colors.lightBlue,
           ),
      ),
    // textAlign: TextAlign.left,
    ),
      if (groupData.userIDs.contains(currentUser))
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) {
                return EditInterest(id: groupData.groupID, type: "group");
              }));
            },
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.green),
              foregroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text('Edit Interests'),
          ),
        ),
    ]
    ),
          const Divider(
            height: 7,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          //Display a button to leave the group if the user is in the group.
          if (groupData.userIDs.contains(currentUser))
            Padding(
                padding: const EdgeInsets.all(10.0),
                //TODO: Make this button conditional on whether or not the user is in the group.
                child: Column(children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EditGroup(id: widget.id);
                      }));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.lightBlueAccent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text('EDIT THIS GROUP'),
                  ),
                  TextButton(
                    onPressed: () {
                      //Remove the user from the group's database. Then Refresh the group's database.
                      groupData.userIDs.remove(currentUser);
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomePage.routeName, (route) => false);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            buildPopupDialog(context),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text('LEAVE THIS GROUP'),
                  ),
                ])),
          //Display a button to join the group if the user is not in the group.
          if (!groupData.userIDs.contains(currentUser))
            Padding(
              padding: const EdgeInsets.all(10.0),
              //TODO: Make this button conditional on whether or not the user is in the group.
              child: TextButton(
                onPressed: () {
                  //Add the user from the group's database. Then Refresh the group's database.
                  groupData.userIDs.add(currentUser);
                  //TODO: Add groupId from user.
                  ref.refresh(groupsDBProvider);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('JOIN THIS GROUP'),
              ),
            ),
        ],
      ),
    ); //Scaffold
  } //build
} //HomePage
