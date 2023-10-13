import 'package:connectuni/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectuni/model/userList.dart';
import 'package:connectuni/model/group.dart';

import 'friendslist.dart';

///  Profile Page that the User sees when they click the Navbar Profile icon.

class CurrentUserProfilePage extends StatefulWidget {
  const CurrentUserProfilePage({
    super.key,
  });

  @override
  State<CurrentUserProfilePage> createState() => _CurrentUserProfilePageState();
}

class _CurrentUserProfilePageState extends State<CurrentUserProfilePage> {
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
    //Temporary local variable to be replaced later.
    User currentUser = usersDB.getUserByID('user-004');
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.people,
              semanticLabel: 'friends list',
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const FriendsList();
                  })
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              semanticLabel: 'settings',
            ),
            onPressed: () {
              //Routes to the Settings Page.
              Navigator.restorablePushNamed(context, '/settings', arguments: '/');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(currentUser.pfp),
                    ),
                  ]
              ),
              Expanded(child: Column(
                children: [
                  Text(
                    currentUser.displayName,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Major: ${currentUser.major}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Projected Grad: ${currentUser.projectedGraduation}',
                    style: const TextStyle(
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
          const Divider(
            height: 7,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Your Interests:",
                    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,),
                    textAlign: TextAlign.left,
                  ),
                  //TODO: Implement interests section here.
                  Column(
                    children: [
                      //TODO: Implement functionality and make cards interactive rather than simply visual.
                      ...currentUser.interests.map((interest) =>
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          title: Center(child: Text(interest, style: const TextStyle(fontWeight: FontWeight.bold))),
                          textColor: Colors.white,
                          tileColor: Colors.lightBlue,
                        ),
                      ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Center(child: Text("Add an interest.", style: TextStyle(fontWeight: FontWeight.bold))),
                      textColor: Colors.white,
                      tileColor: Colors.black54,
                    ),
                  ),
                ]
              )
          ), //Gallery
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
              children:[
                //GroupCardView(name: "ICS 466"),
                //GroupCardView(name: "ICS 312"),
                const Text("Your Courses:",
                  style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,),
                  textAlign: TextAlign.left,
                ),
                Column(
                  children:[
                    ...groupsDB
                        .getGroupsByUser(currentUser.uid)
                        .map((group) =>
                        Card(
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
                                      style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 15.0, top: 5.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("${group.semYear} | ${group.professor}"),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("${group.userIds.length} people"),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () {group.removeUserId(currentUser.uid);},
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      ),
                                      child: const Text('LEAVE'),
                                    ),
                                  )
                              ),
                              const SizedBox(height: 10)
                            ],
                          ),
                        ),
                    ),
                  ]
                ),
              ],
            ),
          ), //Courses
        ],
      ),
    ); //Scaffold
  } //build
} //HomePage
