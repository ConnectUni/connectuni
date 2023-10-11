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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Group groupData = groupsDB.getGroupById(widget.id);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('${groupData.groupName} | ${groupData.professor}'),
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
                ...groupData.getAllUsersInGroup()
                    .map((uName) =>
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(uName.photoURL),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            //TODO: Make this button conditional on whether or not the user is in the group.
            child: TextButton(
              onPressed: (){
                //groupData.removeUserId(PLACE CURRENT USER ID HERE)
                //Placeholder currently only removes the first user:
                groupData.removeUserId('user-001');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('LEAVE THIS GROUP'),
            ),
          ),
        ],
      ),
      //TODO ADD BOTTOM NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Groups',
            icon: Icon(Icons.chat_bubble_outline),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            //TODO Replace with image of users profile picture
            label: 'Profile',
            icon: Icon(Icons.person_2_outlined),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    ); //Scaffold
  } //build
} //HomePage
