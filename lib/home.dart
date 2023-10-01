import 'package:flutter/material.dart';
import 'package:connectuni/model/group.dart';
import 'package:connectuni/model/group_card_view.dart';

/**
 * Landing/Home page that the User is introduced to when logging into their account.
 */

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Groups'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.email_outlined,
              semanticLabel: 'messages',
            ),
            onPressed: () {
              print('Go to inbox');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_active_outlined,
              semanticLabel: 'notifications',
            ),
            onPressed: () {
              print('Go to Notifications page');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          //TODO: Implement functionality and make cards interactive rather than simply visual.
          ...groupsDB
              .getGroups()
              .map((gName) => GroupCardView(name: gName.groupName)),
          const Center(
            //TODO: Implement functionality and change from ICON to Button
            child: Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
              size: 40.0,
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
