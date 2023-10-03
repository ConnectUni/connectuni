import 'package:flutter/material.dart';

import 'chatlist.dart';

// TODO: Import route files

class ConnectUniApp extends StatelessWidget {
  const ConnectUniApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConnectUni',
      initialRoute: '/conversations',
      routes: {
        // TODO: Insert routes
        '/conversations': (BuildContext context) => const ChatList(),
      },
    );
  }
}

// TODO: Build a theme
// TODO: Build a text theme
