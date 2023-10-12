import 'package:flutter/material.dart';

import 'package:connectuni/model/group.dart';
import 'package:connectuni/model/user.dart';

/**
 * Information page for a specific group that displays the group members as well as a description of the selected group.
 * There is an icon at the upper righthand corner for more statistic-related properties of the group.
 */

class GroupInfo extends StatefulWidget {
  final String id;

  const GroupInfo({
    Key? key,
    required this.id,
  }) : super(key: key);

  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  @override
  Widget build(BuildContext context) {
    Group groupData = groupsDB.getGroupById(widget.id);
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
              print('Go to Information page');
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
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ...groupData.getAllUsersInGroup().map(
                      (uName) => Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage(uName.pfp),
                          ),
                          title: Text(uName.displayName),
                        ),
                      ),
                    ),
              ],
            ),
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
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            child: Text(
              groupData.groupDescription,
              softWrap: true,
            ),
          ),
          const Divider(
            height: 7,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          //Display a button to leave the group if the user is in the group.
          if (groupData.userIDs.contains('user-001'))
            Padding(
              padding: const EdgeInsets.all(10.0),
              //TODO: Make this button conditional on whether or not the user is in the group.
              child: TextButton(
                onPressed: () {
                  //Placeholder currently only removes the first user:
                  groupData.removeUserId('user-001');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('LEAVE THIS GROUP'),
              ),
            ),
          //Display a button to join the group if the user is not in the group.
          if (!groupData.userIDs.contains('user-001'))
            Padding(
              padding: const EdgeInsets.all(10.0),
              //TODO: Make this button conditional on whether or not the user is in the group.
              child: TextButton(
                onPressed: () {
                  //Placeholder currently only removes the first user:
                  groupData.addUserId('user-001');
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
