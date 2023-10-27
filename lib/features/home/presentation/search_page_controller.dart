import 'package:flutter/material.dart';

import '../../../screens/groups_screen/search_groups_screen.dart';
import '../../event/presentation/search_events_screen.dart';
import '../../user/presentation/search_people_screen.dart';

class SearchPageController extends StatefulWidget {
  const SearchPageController({Key? key}) : super(key: key);

  @override
  State<SearchPageController> createState() => _SearchPageControllerState();
}

class _SearchPageControllerState extends State<SearchPageController> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        SearchGroupsScreen(pageController: _pageController),
        SearchPeopleScreen(pageController: _pageController),
        SearchEventsScreen(pageController: _pageController),
      ],
    );
  }
}
