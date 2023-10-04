import 'package:connectuni/screens/search_people_screen.dart';
import 'package:connectuni/screens/search_groups_screen.dart';
import 'package:flutter/material.dart';

import 'screens/login.dart';
import 'home/home.dart';
import 'settings.dart';

// TODO: Import route files

class ConnectUniApp extends StatelessWidget {
  ConnectUniApp({Key? key}) : super(key: key);
  final PageController _pageController = PageController(); // this does nothing for now, I need it here to initialize the routes

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConnectUni',
      initialRoute: '/settings',
      routes: {
        // TODO: Insert routes
        //'/login' : (BuildContext context) => const LoginPage(), (REIMPLEMENT ONCE LOGIN PAGE IS MADE SO APP DOESNT BREAK)
        '/': (BuildContext context) => const HomePage(),
        '/settings': (BuildContext context) => const Settings(),
        '/searchgroups': (BuildContext context) => SearchGroupsScreen(pageController: _pageController,),
        '/searchpeople': (BuildContext context) => SearchPeopleScreen(pageController: _pageController,),
      },
    );
  }
}

// TODO: Build a theme
// TODO: Build a text theme
