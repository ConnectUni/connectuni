import 'package:connectuni/features/user/presentation/createprofile.dart';
import 'package:connectuni/features/event/presentation/event_info_screen.dart';
import 'package:connectuni/features/event/presentation/search_events_screen.dart';
import 'package:connectuni/features/authentication/presentation/signup.dart';
import 'package:connectuni/features/user/presentation/friend_list.dart';


import 'package:flutter/material.dart';

import 'features/settings/presentation/app_theme.dart';
import 'features/authentication/presentation/login.dart';
import 'features/home/presentation/home.dart';
import 'features/chat/presentation/chatpage.dart';
import 'features/group/presentation/groupinfo.dart';
import 'features/settings/presentation/settings.dart';
import 'features/user/presentation/createevent.dart';
import 'features/user/presentation/current_user_profile.dart';
import 'features/user/presentation/search_people_screen.dart';
import 'features/group/presentation/search_groups_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Import route files

class ConnectUniApp extends ConsumerWidget {
  ConnectUniApp({Key? key}) : super(key: key);
  final PageController _pageController =
      PageController(); // this does nothing for now, I need it here to initialize the routes

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateProvider);
    return MaterialApp(
      title: 'ConnectUni',
      initialRoute: '/login',
      routes: {
        // TODO: Insert routes
        '/login': (BuildContext context) => const LoginPage(),
        '/signup': (BuildContext context) => const SignUpPage(),
        '/createprofile': (BuildContext context) => const CreateProfile(),
        '/home': (BuildContext context) => const HomePage(),
        '/settings': (BuildContext context) => const Settings(),
        '/searchgroups': (BuildContext context) => SearchGroupsScreen(
              pageController: _pageController,
            ),
        '/searchpeople': (BuildContext context) => SearchPeopleScreen(
              pageController: _pageController,
            ),
        '/search_events': (BuildContext context) => SearchEventsScreen(
              pageController: _pageController,
            ),
        '/createevent': (BuildContext context) => CreateEvent(),
        '/groupinfo': (BuildContext context) => const GroupInfo(id: ''),
        '/eventinfo': (BuildContext context) => const EventInfoScreen(
              id: '',
            ),
        '/conversations': (BuildContext context) => const ChatPage(),
        '/profile': (BuildContext context) => const CurrentUserProfilePage(),
        '/friendslist': (BuildContext context) => const FriendsList(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeState ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

// TODO: Build a theme
// TODO: Build a text theme
