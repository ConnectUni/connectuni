import 'package:connectuni/home/home.dart';
import 'package:connectuni/screens/groups_screen/form-fields/login_email_field.dart';
import 'package:connectuni/screens/groups_screen/form-fields/login_password_field.dart';
import 'package:connectuni/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_list.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _correctEmail = "correct";
  final _correctPassword = "pass";

  //could also implement a disabled Login button - only enabled when credentials are valid (db will have to check all the time though)
  // void _toggleDisabled() {
  //   setState(() {
  //     _validLogin = !_validLogin;
  //   });
  // }
  //
  // void _toggleEnabled() {
  //   setState(() {
  //     _validLogin = !_validLogin;
  //   });
  // }
  final formKey = GlobalKey<FormBuilderState>();
  final emailFieldKey = GlobalKey<FormBuilderFieldState>();
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();
  // final emailErrorProvider =
  //     StateProvider<String?>((ref) => null); //set Email error to null

  void _checkValidEmail(UserList userList) {
    if (formKey.currentState!.validate()) {
      // Retrieving the email entered by the user
      String email = emailFieldKey.currentState!.value;
      // Check if the email exists in the user list
      if (userList.getUserByEmail(email) != null) {
        ref.read(currentUserProvider.notifier).state =
            userList.getUserByEmail(email).getUid();
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => const HomePage()));
      } else {
        //show error message for invalid email
        // emailFieldKey.currentState?.invalidate('Email already taken');
        // ref.read(emailErrorProvider.notifier).state = "Invalid email";
        // setState(() {}); //trigger rebuild
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserList userList = ref.watch(userDBProvider);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: 50.0), //controls width of text fields
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                const Text(
                  "Welcome to",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                //change image: update pubspec too
                Image.asset('assets/images/Logo.png'),
              ],
            ),
            const SizedBox(
              height: 75.0,
            ),
            FormBuilder(
              key: formKey,
              child: Column(children: [
                LoginEmailField(fieldKey: emailFieldKey),
                LoginPasswordField(fieldKey: passwordFieldKey),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 100.0,
                  width: 40.0,
                ),
                ElevatedButton(
                  onPressed: () => _checkValidEmail(userList),
                  child: const Text("LOGIN"),
                ),
                ElevatedButton(
                  onPressed: () {
                    //create new account stuff - pick username, icons, etc.
                    //uncomment out after creating SignUpPage
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: const Text('SIGN UP'),
                ),

                //clear button
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      emailFieldKey.currentState!.didChange(null);
                      passwordFieldKey.currentState!.didChange(null);
                    },
                    child: const Text("CLEAR"),
                  ),
                ), //next button
              ],
            ),
          ],
        ),
      ),
    );
  }
}
