import 'package:connectuni/features/home/domain/global_variables.dart';
import 'package:flutter/material.dart';

/// Landing/Home page that the User is introduced to when logging into their account.

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  static const routeName = '/home';
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController pageController; // navigation bar page controller

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigationTapped(int index) {
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: _onPageChanged, // when the page changes, calls the onPageChanged function
        children: screenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
        unselectedIconTheme: Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Groups',
            icon: Icon(Icons.chat_bubble_outline),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Calendar',
            icon: Icon(Icons.calendar_month_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_2_outlined),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: navigationTapped, // when a tab is tapped, the page controller jumps to the corresponding page
      ),
    ); //Scaffold
  } //build
} //HomePage
