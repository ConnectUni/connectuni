import 'package:connectuni/features/home/presentation/home.dart';
import 'package:connectuni/features/group/presentation/form-fields/login_email_field.dart';
import 'package:connectuni/features/group/presentation/form-fields/login_password_field.dart';
import 'package:connectuni/features/authentication/presentation/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user_list.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final emailFieldKey = GlobalKey<FormBuilderFieldState>();
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  void _checkValidLogin(UserList userList) {
    if (formKey.currentState!.validate()) {
      String email = emailFieldKey.currentState!.value;
      // Check if the email exists matches in the user list
      if (userList.getUserByEmail(email) != null) {
        ref.read(currentUserProvider.notifier).state =
            userList.getUserByEmail(email).getUid();
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => const HomePage()));
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
              horizontal: 50.0), //controls width of textfields
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
                LoginEmailField(
                  fieldKey: emailFieldKey,
                ),
                LoginPasswordField(
                  fieldKey: passwordFieldKey,
                  getPassword: () => passwordFieldKey.currentState?.value,
                  email: () => emailFieldKey.currentState?.value,
                  userList: userList,
                ),
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
                  onPressed: () => _checkValidLogin(userList),
                  child: const Text("LOGIN"),
                ),
                ElevatedButton(
                  onPressed: () {
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
