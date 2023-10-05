import 'package:connectuni/screens/friendslist.dart';
import 'package:flutter/material.dart';

import 'screens/login.dart';
import 'home/home.dart';
import 'screens/chatpage.dart';
import 'screens/groupinfo.dart';
import 'screens/settings.dart';
import 'screens/profile.dart';
import 'screens/search_people_screen.dart';
import 'screens/search_groups_screen.dart';

// TODO: Import route files

class ConnectUniApp extends StatelessWidget {
  ConnectUniApp({Key? key}) : super(key: key);
  final PageController _pageController = PageController(); // this does nothing for now, I need it here to initialize the routes

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConnectUni',
      initialRoute: '/',
      routes: {
        // TODO: Insert routes
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage(),
        '/searchgroups': (BuildContext context) => SearchGroupsScreen(pageController: _pageController,),
        '/searchpeople': (BuildContext context) => SearchPeopleScreen(pageController: _pageController,),
        '/groupinfo': (BuildContext context) => const GroupInfo(),
        '/conversations': (BuildContext context) => const ChatPage(),
        '/profile': (BuildContext context) => const ProfilePage(),
        '/settings': (BuildContext context) => const Settings(),
        '/friendslist': (BuildContext context) => const FriendsList(),
      },
    );
  }
}

// TODO: Build a theme
// TODO: Build a text theme
