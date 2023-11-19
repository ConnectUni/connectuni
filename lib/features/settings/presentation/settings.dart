import 'package:connectuni/features/settings/data/settings_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/presentation/signin_view.dart';


/// Settings page that allows the user to changes their preferences.

class Settings extends ConsumerStatefulWidget {
  const Settings({
    super.key,
  });

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

void updateThemeMode(ThemeMode? newThemeMode, WidgetRef ref) {
  if (newThemeMode == null) return;
  if (newThemeMode == ref.read(currentThemeModeProvider)) return;
  ref.read(currentThemeModeProvider.notifier).setThemeMode(newThemeMode);
}

class _SettingsState extends ConsumerState<Settings> {

  @override
  Widget build(BuildContext context) {
    ref.watch(currentThemeModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Privacy'),
      ),
      body: ListView(
        children: [
          //TODO: Implement functionality and make cards interactive rather than simply visual.
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.arrow_downward),
              title: Text("Settings",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.notifications_active_outlined,),
              textColor: Colors.black,
              tileColor: FlexColor.greenLightPrimary,
            ),
          ),
          ListTile(
            leading: Switch(
              value: ref.watch(currentThemeModeProvider) == ThemeMode.dark,
              onChanged: (value) {
                updateThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light, ref);
              },
            ),
            title: const Text("Dark Mode"),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Center(
                  child: Text("Change Password",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              textColor: Colors.white,
              tileColor: FlexColor.redLightPrimary,
            ),
          ),
          SizedBox(
            height: 75.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: () => {
                  FirebaseAuth.instance.signOut(),
                  Navigator.pushReplacementNamed(context, SignInView.routeName),
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(FlexColor.deepBlueLightTertiary),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('Log Out'),
              ),
            ),
          ),
        ],
      ),
    ); //Scaffold
  } //build
} //HomePage
