import 'package:connectuni/screens/createevent.dart';
import 'package:connectuni/screens/search_events_screen.dart';
import 'package:flutter/material.dart';

import 'features/authentication/presentation/signup.dart';
import 'features/chat/presentation/chatpage.dart';
import 'features/event/presentation/event_info_screen.dart';
import 'features/home/presentation/home.dart';
import 'features/settings/presentation/settings.dart';
import 'features/user/presentation/createprofile.dart';
import 'features/user/presentation/current_user_profile.dart';
import 'features/user/presentation/friend_list.dart';
import 'features/user/presentation/search_people_screen.dart';
import 'model/app_theme.dart';
import 'screens/login.dart';
import 'screens/groups_screen/groupinfo.dart';
import 'screens/groups_screen/search_groups_screen.dart';
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
        '/searchevents': (BuildContext context) => SearchEventsScreen(
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
