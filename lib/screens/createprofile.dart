import 'package:connectuni/components/groupselectorwidget.dart';
import 'package:flutter/material.dart';
import 'package:connectuni/model/user.dart';
import '../components/interestswidget.dart';
import '../components/pfpwidget.dart';
import '../model/userList.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);
  static const routeName = '/createprofile';

  @override
  CreateProfileState createState() => CreateProfileState();
}

class CreateProfileState extends State<CreateProfile> {
  final _usernameController = TextEditingController();

  //temporary user to test, need to implement way to be "current" user
  late User currentUser = usersDB.getUserByID('user-004');
  List<String> interests = [''];
  String? _selectedSemester;
  String? _selectedYear;
  String grad = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Profile'),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) =>
              SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        ProfileWidget(
                            image: AssetImage(currentUser.pfp),
                            onEditIconTap: () {
                              // TODO Implement way to pick image
                            }),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() => currentUser.displayName = value);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        const Text(
                          'Select your major',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        buildMajorSelector(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Projected Graduation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    buildGraduationSelector(),
                    const SizedBox(height: 20),
                    const Text(
                      'Select your Interests',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 375,
                      child: InterestsSelector(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Select your Groups',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    ///Currently provides all available groups to
                    ///select from, need to implement way to select
                    ///or add just groups relevant to the user?
                    const GroupSelector(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        ///implement update/save user?
                        ///then navigate to home screen
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Text('Continue'),
                    ),
                  ]
              ),
            ),
          ),
        )
    );
  }


  Widget buildMajorSelector() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: DropdownButtonFormField(
        items: <String>[
          'Computer Science',
          'Finance',
          'Liberal Arts',
          'Mathematics',
          'Graphic Design',
          'Business'
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            currentUser.major = value!;
          });
        },
      ),
    );
  }

  Widget buildGraduationSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedSemester,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSemester = newValue!;
                  grad = '$_selectedSemester $_selectedYear';
                  currentUser.projectedGraduation = grad;
                });
              },
              items: <String>[
                'Fall',
                'Spring'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedYear,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedYear = newValue!;
                  grad = '$_selectedSemester $_selectedYear';
                  currentUser.projectedGraduation = grad;
                });
              },
              items: <String>[
                '2023',
                '2024',
                '2025',
                '2026',
                '2027',
                '2028'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
