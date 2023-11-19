import 'package:connectuni/features/event/presentation/event_info_screen.dart';
import 'package:connectuni/features/event/presentation/search_events_screen.dart';
import 'package:connectuni/features/settings/data/settings_db.dart';
import 'package:connectuni/features/user/presentation/friend_list.dart';


import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'features/authentication/presentation/forgot_password_view.dart';
import 'features/authentication/presentation/signin_view.dart';
import 'features/authentication/presentation/verify_email_view.dart';
import 'features/event/presentation/eventCalendar.dart';
import 'features/group/presentation/add_group.dart';
import 'features/home/presentation/home.dart';
import 'features/group/presentation/groupinfo.dart';
import 'features/settings/presentation/settings.dart';
import 'features/event/presentation/createevent.dart';
import 'features/user/presentation/add_user.dart';
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
    return MaterialApp(
      title: 'ConnectUni',
      initialRoute: '/signin',
      theme: FlexThemeData.light(
        scheme: FlexScheme.deepBlue,
        appBarStyle: FlexAppBarStyle.primary,
        background: FlexColor.deepBlueLightPrimaryContainer,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
        ),
      ),
      darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.deepBlue,
          appBarBackground: FlexColor.deepBlueDarkPrimaryContainer,
          background: FlexColor.deepBlueDarkPrimaryContainer,
        subThemesData: const FlexSubThemesData(
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
        ),
      ),
      themeMode: ref.watch(currentThemeModeProvider),
      routes: {
        // TODO: Insert routes
        '/signin': (BuildContext context) => const SignInView(),
        '/add_user': (BuildContext context) => AddUser(),
        '/verify-email': (BuildContext context) => const VerifyEmailView(),
        '/forgot-password': (BuildContext context) => const ForgotPasswordView(),
        '/home': (BuildContext context) => const HomePage(),
        '/settings': (BuildContext context) => const Settings(),
        '/search_groups': (BuildContext context) => SearchGroupsScreen(
              pageController: _pageController,
            ),
        '/search_people': (BuildContext context) => SearchPeopleScreen(
              pageController: _pageController,
            ),
        '/search_events': (BuildContext context) => SearchEventsScreen(
              pageController: _pageController,
            ),
        '/add_group': (BuildContext context) => AddGroup(),
        '/createevent': (BuildContext context) => CreateEvent(),
        '/groupinfo': (BuildContext context) => const GroupInfo(id: ''),
        '/eventinfo': (BuildContext context) => const EventInfoScreen(
              id: '',
            ),
        '/profile': (BuildContext context) => const CurrentUserProfilePage(),
        '/friendslist': (BuildContext context) => const FriendsList(),
        '/events_calendar': (BuildContext context) => const EventCalendar(),
      },
    );
  }
}

// TODO: Build a theme
// TODO: Build a text theme
