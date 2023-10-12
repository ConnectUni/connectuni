import 'package:connectuni/screens/eventCalendar.dart';
import 'package:connectuni/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:connectuni/home/search_page_controller.dart';
import 'package:connectuni/screens/groups_screen.dart';

// This is the list of pages that will be displayed in the bottom navigation bar in-order.
List<Widget> screenItems = [
  const GroupsScreen(),
  const SearchPageController(),
  EventCalendar(),
  const ProfilePage()
];

// This is a list of interests that can be called from anywhere in the app.
List<String> interests = [
  'Computer Science',
  'Mathematics',
  'Business',
  'Art',
  'Music',
  'Graphic Design',
  'Finance',
];
