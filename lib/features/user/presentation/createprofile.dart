import 'package:flutter/material.dart';
import 'package:connectuni/features/user/domain/user.dart';
import '../../group/presentation/groupselectorwidget.dart';
import '../../home/presentation/home.dart';
import '../data/user_providers.dart';
import 'interestswidget.dart';
import 'pfpwidget.dart';
import '../domain/user_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateProfile extends ConsumerStatefulWidget {
  static const routeName = '/createprofile';
  const CreateProfile({super.key});

  @override
  CreateProfileState createState() => CreateProfileState();
}

class CreateProfileState extends ConsumerState<CreateProfile> {
  final _usernameController = TextEditingController();
  List<String> interests = [''];
  String? _selectedSemester;
  String? _selectedYear;
  String grad = '';

  @override
  Widget build(BuildContext context) {
    final UserList userList = ref.read(userDBProvider);
    final User currentUser =
        userList.getUserByID(ref.read(currentUserProvider));
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomePage.routeName, (route) => false);
                      },
                      child: const Text('Continue'),
                    ),
                  ]),
            ),
          ),
        ));
  }

  Widget buildMajorSelector() {
    final UserList userList = ref.read(userDBProvider);
    final User currentUser =
        userList.getUserByID(ref.read(currentUserProvider));
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
    final UserList userList = ref.read(userDBProvider);
    final User currentUser =
        userList.getUserByID(ref.read(currentUserProvider));
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
              items: <String>['Fall', 'Spring']
                  .map<DropdownMenuItem<String>>((String value) {
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
              items: <String>['2023', '2024', '2025', '2026', '2027', '2028']
                  .map<DropdownMenuItem<String>>((String value) {
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
