import 'package:connectuni/home/home.dart';
import 'package:connectuni/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordCheckController.dispose();
    super.dispose();
  }

  bool _filledFields() {
    if (_usernameController.value != null &&
        _passwordController.value != null &&
        _passwordCheckController.value != null &&
        _emailController.value != null) {
      return true;
    }
    return false;
  }

  bool _samePassword() {
    if (_passwordController.value == _passwordCheckController.value) {
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
  //
  // String? get _errorMessage {
  //   final input = controllerName.value.text;
  //   if (input.isEmpty) {
  //     return true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
            const Text('Enter your email'),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  filled: true,
                  labelText: "Email",
                  errorText: !_emptyField(_emailController)
                      ? 'Email can\'t be empty'
                      : null),
              onChanged: (text) => setState(() => _emailController.value),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text('Enter your username'),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  filled: true,
                  labelText: "Username",
                  errorText: !_emptyField(_usernameController)
                      ? 'Username can\'t be empty'
                      : null),
              onChanged: (text) => setState(() => _usernameController.value),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text('Enter your password'),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: "Password",
                errorText: !_emptyField(_passwordController)
                    ? 'Password can\'t be empty'
                    : null,
              ),
              onChanged: (text) => setState(() => _passwordController.value),
              obscureText: true,
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text('Re-type your password'),
            TextField(
              controller: _passwordCheckController,
              //install a listener to compare it to the password value above
              decoration: InputDecoration(
                filled: true,
                labelText: "Password",
                errorText: !_emptyField(_passwordCheckController)
                    ? 'Password can\'t be empty'
                    : null,
              ),
              onChanged: (text) =>
                  setState(() => _passwordCheckController.value),
              obscureText: true,
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
                    _emailController.clear();
                    _passwordController.clear();
                    _usernameController.clear();
                    _passwordCheckController.clear();
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
                    if (_filledFields()) {
                      //check if all fields are filled
                      if (_samePassword()) {
                        //validate passwords match
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      } else {
                        _emailController.text = "not same passowrd";
                      }
                    } else {
                      _emailController.text = "whaaauhhhh";
                    }

                    //create new account stuff - pick username, icons, etc.
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
