import 'package:flutter/material.dart';
import 'package:connectuni/model/group.dart';
import 'package:connectuni/model/group_card_view.dart';

/**
 * Landing/Home page that the User is introduced to when logging into their account.
 */

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        title: const Text('My Profile'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              semanticLabel: 'settings',
            ),
            onPressed: () {
              //TODO: Route this page to the Application Settings Page.
              print('GO TO APP SETTINGS PAGE');
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/You.jpg'),
                  ),
            ]
                ),
                Expanded(child: Column(
                  children: [
                    const Text(
                      'Alberta Ritter',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Major: Computer Science',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const Text(
                      'Projected Grad: May 2024',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ),
                  ],
                ),
                ),
              ]
            ),
          ),
          const Divider(
            height: 7,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          Container(), //Gallery
          const Divider(
            height: 7,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          ListTile(), //Courses
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
