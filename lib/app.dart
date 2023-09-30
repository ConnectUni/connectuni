import 'package:flutter/material.dart';

import 'login.dart';
import 'home.dart';

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
        //'/login' : (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage(),
      },
    );
  }
}

// TODO: Build a theme
// TODO: Build a text theme
