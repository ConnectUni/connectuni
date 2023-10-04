import 'package:flutter/material.dart';

import 'chatpage.dart';
import 'groupinfo.dart';
import 'login.dart';
import 'home.dart';
import 'settings.dart';

// TODO: Import route files

class ConnectUniApp extends StatelessWidget {
  const ConnectUniApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConnectUni',
      initialRoute: '/',
      routes: {
        // TODO: Insert routes
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage(),
        '/settings': (BuildContext context) => const Settings(),
        '/groupinfo': (BuildContext context) => const GroupInfo(),
        '/conversations': (BuildContext context) => const ChatPage(),
      },
    );
  }
}

// TODO: Build a theme
// TODO: Build a text theme
