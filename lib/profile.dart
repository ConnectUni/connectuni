import 'package:flutter/material.dart';
//import 'package:connectuni/model/group_card_view.dart';

/**
 *  Profile Page that the User sees when they click the Navbar Profile icon.
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
              //Routes to the Settings Page.
              Navigator.restorablePushNamed(context, '/settings', arguments: '/');
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
          Container(
            padding: EdgeInsets.all(10.0),
            child:
              const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Your Gallery:",
                    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image(
                            image: AssetImage('assets/images/Feed1.jpg'),
                          ),
                        ],
                      ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:[
                          Image(
                            image: AssetImage('assets/images/Feed2.jpg'),
                          ),
                        ],
                      ),
                      ),
                    ],
                  ),
                  Center(
                    //TODO: Implement functionality and change from ICON to Button
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey,
                      size: 40.0,
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
                Card(
                    elevation: 8,
                  color: Colors.grey,
                    child: Column(
                      children: [
                        ListTile(
                            title: Text("ICS 311",
                                style: Theme.of(context).textTheme.titleLarge)),
                        const Padding(
                            padding: EdgeInsets.only(left: 15.0, top: 5.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Fall 2021 | Peter Sadowski"),
                            )
                        ),
                        const Padding(
                            padding: EdgeInsets.only(left: 15.0, top: 2.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("32 people"),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: null,
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
                Card(
                  elevation: 8,
                  color: Colors.grey,
                  child: Column(
                    children: [
                      ListTile(
                          title: Text("JPN 202",
                              style: Theme.of(context).textTheme.titleLarge),),
                      const Padding(
                          padding: EdgeInsets.only(left: 15.0, top: 2.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Spring 2023 | Tomoko Iwai"),
                          )
                      ),
                      const Padding(
                          padding: EdgeInsets.only(left: 15.0, top: 2.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("28 people"),
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: null,
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
              ],
            ),
          ), //Courses
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
