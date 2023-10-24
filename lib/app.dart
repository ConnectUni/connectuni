import 'package:connectuni/screens/createprofile.dart';
import 'package:connectuni/screens/event_info_screen.dart';
import 'package:connectuni/screens/search_events_screen.dart';
import 'package:connectuni/screens/signup.dart';
import 'package:connectuni/screens/friend_list.dart';

import 'package:flutter/material.dart';

import 'screens/login.dart';
import 'home/home.dart';
import 'screens/chatpage.dart';
import 'screens/groupinfo.dart';
import 'screens/settings.dart';
import 'screens/current_user_profile.dart';
import 'screens/search_people_screen.dart';
import 'screens/search_groups_screen.dart';

// TODO: Import route files

class ConnectUniApp extends StatelessWidget {
  ConnectUniApp({Key? key}) : super(key: key);
  final PageController _pageController =
      PageController(); // this does nothing for now, I need it here to initialize the routes

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConnectUni',
      initialRoute: '/login',
      routes: {
        // TODO: Insert routes
        '/login': (BuildContext context) => const LoginPage(),
        '/signup': (BuildContext context) => const SignUpPage(),
        '/createprofile': (BuildContext context) => const CreateProfile(),
        '/home': (BuildContext context) => const HomePage(),
        '/settings': (BuildContext context) => const Settings(),
        '/searchgroups': (BuildContext context) => SearchGroupsScreen(
              pageController: _pageController,
            ),
        '/searchpeople': (BuildContext context) => SearchPeopleScreen(
              pageController: _pageController,
            ),
        '/searchevents': (BuildContext context) => SearchEventsScreen(
              pageController: _pageController,
            ),
        '/groupinfo': (BuildContext context) => const GroupInfo(id: ''),
        '/eventinfo': (BuildContext context) => const EventInfoScreen(
              id: '',
            ),
        '/conversations': (BuildContext context) => const ChatPage(),
        '/profile': (BuildContext context) => const CurrentUserProfilePage(),
        '/friendslist': (BuildContext context) => const FriendsList(),
      },
    );
  }
}

// TODO: Build a theme
// TODO: Build a text theme
