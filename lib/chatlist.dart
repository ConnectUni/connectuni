import 'package:flutter/material.dart';

import 'chatpage.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ChatPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: const [
          //TODO ADD BOTTOM NAVBAR
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Groups",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label:"Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label:"Profile",
          ),
        ],
      ),
    );
  }
}