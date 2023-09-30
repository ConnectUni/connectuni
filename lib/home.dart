import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          title: const Text('My Groups'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.email_outlined,
                semanticLabel: 'messages',
              ),
              onPressed: () {
                print('Go to inbox');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications_active_outlined,
                semanticLabel: 'notifications',
              ),
              onPressed: () {
                print('Go to Notifications page');
              },
            ),
          ],
      ),
      body: ListView(
        children: [],
      ), //TODO ADD LIST VIEW
      //TODO ADD BOTTOM NAV BAR
    ); //Scaffold
  } //build
} //HomePage