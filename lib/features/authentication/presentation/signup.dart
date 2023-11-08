import 'package:connectuni/features/group/presentation/form-fields/signup_username_field.dart';
import 'package:connectuni/features/user/presentation/createprofile.dart';
import 'package:connectuni/features/user/presentation/current_user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../group/presentation/form-fields/signup_email_field.dart';
import '../../group/presentation/form-fields/signup_passwordCheck_field.dart';
import '../../group/presentation/form-fields/signup_password_field.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user_list.dart';
import 'login.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends ConsumerState<SignUpPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final userNameFieldKey = GlobalKey<FormBuilderFieldState>();
  final emailFieldKey = GlobalKey<FormBuilderFieldState>();
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();
  final passwordCheckFieldKey = GlobalKey<FormBuilderFieldState>();

  bool _checkValidForm(UserList userList) {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  bool _emptyField(TextEditingController controllerName) {
    if (controllerName.value.text.isEmpty) {
      return false;
    }
    return true;
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
                Text(
                  'Sign up for ConnectUni!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(
              height: 75.0, //padding from title to textfields
            ),
            FormBuilder(
              key: formKey,
              child: Column(children: [
                SignupUsernameField(
                  fieldKey: userNameFieldKey,
                ),
                SignupEmailField(
                  fieldKey: emailFieldKey,
                ),
                SignupPasswordField(
                  fieldKey: passwordFieldKey,
                ),
                SignupPasswordCheckField(
                  fieldKey: passwordCheckFieldKey,
                  getPassword: () => passwordFieldKey.currentState?.value,
                ),
              ]),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 100.0,
                  width: 50.0,
                ),
                //clear button
                TextButton(
                  onPressed: () {
                    emailFieldKey.currentState!.didChange(null);
                    passwordFieldKey.currentState!.didChange(null);
                  },
                  child: const Text("CLEAR"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text("BACK"),
                ),
                ElevatedButton(
                  // onPressed: () {
                  //   Navigator.push(
                  //     context,
                  //     CupertinoPageRoute(
                  //         builder: (context) => const ProfilePage()),
                  //   );

                  onPressed: () {
                    if (_checkValidForm(userList)) {
                      //send info to create profile page where it completes the necessary data to make a new user
                      //call to create profile page
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const CreateProfile()),
                      );
                    }
                  },
                  child: const Text('SIGN UP'),
                ),
                //next button
              ],
            ),
          ],
        ),
      ),
    );
  }
}
