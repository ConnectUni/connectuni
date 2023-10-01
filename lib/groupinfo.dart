import 'package:flutter/material.dart';


/**
 * Landing/Home page that the User is introduced to when logging into their account.
 */

class GroupInfo extends StatefulWidget {
  const GroupInfo({
    super.key,
  });

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
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('ICS 466 | Philip Johnson'),
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
        children: const [
          //TODO: Implement functionality and make cards interactive rather than simply visual.
          Padding(
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
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/images/You.jpg'),
                    ),
                    title: Text('You'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/images/Person 1.jpg'),
                    ),
                    title: Text('Person 1'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/images/Person 2.jpg'),
                    ),
                    title: Text('Person 2'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/images/Person 3.jpg'),
                    ),
                    title: Text('Person 3'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/images/Person4.jpg'),
                    ),
                    title: Text('Person 4'),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 7,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Information:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
