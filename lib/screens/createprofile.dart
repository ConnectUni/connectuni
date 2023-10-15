import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectuni/model/user.dart';
import 'package:image_picker/image_picker.dart';
import '../components/interestswidget.dart';
import '../components/pfpwidget.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);
  static const routeName = '/createprofile';

  @override
  CreateProfileState createState() => CreateProfileState();
}

class CreateProfileState extends State<CreateProfile> {
  final _usernameController = TextEditingController();
  late User currentUser;
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
                        SizedBox(height: 20),
                        ProfileWidget(
                            currentUser: currentUser,
                            onClicked: () async{}, image: currentUser.pfp
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            currentUser.displayName = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        const Text(
                          'Select your major',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
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
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'Projected Graduation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
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
                          SizedBox(width: 20),
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
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Select your Interests',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 400,
                      child: InterestsSelector(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
