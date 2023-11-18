import 'package:connectuni/features/event/presentation/eventCalendar.dart';
import 'package:connectuni/features/user/presentation/current_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:connectuni/features/home/presentation/search_page_controller.dart';
import 'package:connectuni/features/group/presentation/groups_screen.dart';

// This is the list of pages that will be displayed in the bottom navigation bar in-order.
List<Widget> screenItems = [
  const GroupsScreen(),
  const SearchPageController(),
  EventCalendar(),
  const CurrentUserProfilePage()
];

