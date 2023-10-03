import 'dart:ffi';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _correctUserName = "correct";
  final _correctPassword = "pass";
  late bool _validLogin = true;

  @override
  void initState() {
    _validLogin = true;
  }

  void _toggleDisabled() {
    setState(() {
      _validLogin = !_validLogin;
    });
  }

  void _toggleEnabled() {
    if (_usernameController.value == _correctUserName) {
      setState(() {
        _validLogin = !_validLogin;
      });
    }
  }

  Widget _buildCounterButton() {
    return ElevatedButton(
      // onPressed: _validLogin ? null :,
      onPressed: () {
        _validLogin ? _toggleDisabled : null;
        _validLogin ? _toggleEnabled : _usernameController.text = "what";
      },
      // },
      // onPressed: () {
      //
      //   if (_validLogin) {
      //     //would switch to user's home screen
      //     _usernameController.text = "huh";
      //   } else {}
      // },
      child: Text(_validLogin ? "LOGIN" : "INCORRECT"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Text(
                  'ConnectUni',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Image.asset('assets/people.png'),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Email",
                )),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: "Password",
              ),
              obscureText: true,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCounterButton(),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    //create new account stuff - pick username, icons, etc.
                  },
                  child: const Text('SIGN UP'),
                ),

                //clear button
                TextButton(
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                  child: const Text("CLEAR"),
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
