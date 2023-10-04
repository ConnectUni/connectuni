import 'package:flutter/material.dart';

/**
 * Setting page for the application that allows the user to change information to fit their preferences.
 */

class Settings extends StatefulWidget {
  const Settings({
    super.key,
  });

  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
  //TODO: Implement the actual functionality of the settings boolean.
  bool notif = true;
  bool nFriend = true;
  bool groupMemb = true;
  bool search = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Privacy'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings_applications_outlined,
              semanticLabel: 'applications settings',
            ),
            onPressed: () {
              print('Open the settings');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          //TODO: Implement functionality and make cards interactive rather than simply visual.
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.arrow_downward, color: Colors.black),
              title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.notifications_active_outlined, color: Colors.black),
              textColor: Colors.black,
              tileColor: Colors.green,
            ),
          ),
          ListTile(
            leading: Switch(
              value: notif,
              activeColor: Colors.black26,
              onChanged: (bool value) {
                setState(() {
                  notif = value;
                });
              },
            ),
            title:const Text("Receive notifications"),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.arrow_downward, color: Colors.black),
              title: Text("Privacy", style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.messenger_outline, color: Colors.black),
              textColor: Colors.black,
              tileColor: Colors.green,
            ),
          ),
          ListTile(
            leading: Switch(
              value: nFriend,
              activeColor: Colors.black26,
              onChanged: (bool value) {
                setState(() {
                  nFriend = value;
                });
              },
            ),
            title: const Text("Allow messages from non-friends"),
          ),
          ListTile(
            leading: Switch(
              value: groupMemb,
              activeColor: Colors.black26,
              onChanged: (bool value) {
                setState(() {
                  groupMemb = value;
                });
              },
            ),
            title: const Text("Allow messages from group members"),
          ),
          ListTile(
            leading: Switch(
              value: search,
              activeColor: Colors.black26,
              onChanged: (bool value) {
                setState(() {
                  search = value;
                });
              },
            ),
            title: const Text("Allow discovery on search page"),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Center(child: Text("Change Password", style: TextStyle(fontWeight: FontWeight.bold))),
              textColor: Colors.black,
              tileColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    ); //Scaffold
  } //build
} //HomePage
