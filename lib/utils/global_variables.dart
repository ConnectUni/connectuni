import 'package:connectuni/screens/eventCalendar.dart';
import 'package:connectuni/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:connectuni/home/search_page_controller.dart';
import 'package:connectuni/screens/groups_screen.dart';

List<Widget> screenItems = [
  const GroupsScreen(),
  const SearchPageController(),
  const EventCalendar(),
  const ProfilePage()
];
