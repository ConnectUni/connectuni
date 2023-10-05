import 'package:connectuni/home/home.dart';
import 'package:connectuni/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _correctEmail = "correct";
  final _correctPassword = "pass";
  // late bool _validLogin = true;
  //
  // @override
  // void initState() {
  //   _validLogin = false;
  // }

  bool checkValidLogin() {
    if (_emailController.text == _correctEmail &&
        _passwordController.text == _correctPassword) {
      return true;
    }
    return false;
  }

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
                  'ConnectUni',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                //change image: update pubspec too
                Image.asset('assets/images/TEST_LOGO.png'),
              ],
            ),
            const SizedBox(
              height: 75.0,
            ),
            TextField(
                controller: _emailController,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 100.0,
                  width: 50.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (checkValidLogin()) {
                      //would switch to user's home screen
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    } else {
                      _emailController.text = "nuh";
                    }
                  },
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
                TextButton(
                  onPressed: () {
                    _emailController.clear();
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
