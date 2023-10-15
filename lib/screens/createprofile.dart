import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectuni/model/user.dart';
import '../model/userList.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key:key);
  static const routeName = '/createprofile';
  @override
  CreateProfileState createState() => CreateProfileState();
}

class CreateProfileState extends State<CreateProfile> {
  final _usernameController = TextEditingController();
  User currentUser = usersDB.getUserByID('user-004');
  File? _profileImage;
  List<String> interests = [''];
  String? _selectedSemester;
  String? _selectedYear;
  String grad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        physics: BouncingScrollPhysics(),
          children: <Widget> [
            Center(
              child: GestureDetector(
                onTap: () async {
                  //TODO implement picking photo functionality
                  currentUser.setPhotoURL(_profileImage as String);
                  },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null ? Icon(Icons.camera_alt, size: 40) : null,
                ),
              ),
            ),
            ///USERNAME
            const SizedBox(height: 20),
            Text('Username'),
            TextField(
            controller: _usernameController,
              decoration: const InputDecoration (
              ),
              onChanged: (value) {
                setState(() {
                  currentUser.displayName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Select Your Major'),
            DropdownButtonFormField(
                items:
                  <String>[
                    'Computer Science',
                    'Finance',
                    'Liberal Arts',
                    'Mathematics',
                    'Graphic Design',
                    'Business'].map((String value) {
                      return DropdownMenuItem<String> (
                        value: value,
                        child: Text(value),
                      );
                  }).toList() ,
                onChanged:(value) {
                  setState(() {
                    currentUser.major = value!;
                  });
                },
                ),
            SizedBox(height: 20),
            Text('Projected Graduation'),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        hint: Text('Select Semester'),
                        value: _selectedSemester,
                        items: <String>['Fall', 'Spring', 'Summer']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSemester = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),  // To provide some spacing between dropdowns
                Expanded(
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        hint: Text('Select Year'),
                        value: _selectedYear,
                        items: List.generate(10, (index) => (DateTime.now().year + index).toString())
                            .map((String year) {
                          return DropdownMenuItem<String>(
                            value: year,
                            child: Text(year),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedYear = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
                grad = "$_selectedSemester $_selectedYear"',
            ),

            SizedBox(height: 20),


        ],
      ),
    );
  }
}