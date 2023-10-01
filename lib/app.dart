import 'package:flutter/material.dart';

import 'groupinfo.dart';

// TODO: Import route files

class ConnectUniApp extends StatelessWidget {
  const ConnectUniApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConnectUni',
      initialRoute: '/groupinfo',
      routes: {
        // TODO: Insert routes
        '/groupinfo': (BuildContext context) => const GroupInfo(),
      },
    );
  }
}

// TODO: Build a theme
// TODO: Build a text theme
