import 'package:flutter/material.dart';

import 'groupinfo.dart';
import 'login.dart';
import 'home.dart';
import 'settings.dart';
import 'profile.dart';

// TODO: Import route files

class ConnectUniApp extends StatelessWidget {
  const ConnectUniApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConnectUni',
      initialRoute: '/profile',
      routes: {
        // TODO: Insert routes
        //'/login' : (BuildContext context) => const LoginPage(), (REIMPLEMENT ONCE LOGIN PAGE IS MADE SO APP DOESNT BREAK)
        '/': (BuildContext context) => const HomePage(),
        '/settings': (BuildContext context) => const Settings(),
        '/groupinfo': (BuildContext context) => const GroupInfo(),
        '/profile': (BuildContext context) => const ProfilePage(),
      },
    );
  }
}

// TODO: Build a theme
// TODO: Build a text theme
