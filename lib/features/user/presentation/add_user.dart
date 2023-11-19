
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../group/presentation/form-fields/reset_button.dart';
import '../../group/presentation/form-fields/submit_button.dart';
import '../../home/presentation/home.dart';
import '../data/user_providers.dart';
import '../domain/user.dart' as UniUser;
import '../domain/user_list.dart';
import 'form-fields/display_name_field.dart';
import 'form-fields/grad_field.dart';
import 'form-fields/major_field.dart';
import 'form-fields/pfp_field.dart';
import 'form-fields/status_field.dart';



class AddUser extends ConsumerWidget {
  static const routeName = '/add_user';
  AddUser({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final _displayNameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _pfpFieldKey = GlobalKey<FormBuilderFieldState>();
  final _majorFieldKey = GlobalKey<FormBuilderFieldState>();
  final _gradFieldKey = GlobalKey<FormBuilderFieldState>();
  final _statusFieldKey = GlobalKey<FormBuilderFieldState>();

  final List<UniUser.User> friends = [];
  final List<String> groupIDs = [];
  final List<String> eventIDs = [];
  final List<String> interests = [];

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String email = auth.currentUser!.email!;
    final UserList usersDB = ref.watch(userDBProvider);
    int id = usersDB.userLength() + 1;
    String getUserID() {
      if (id < 10) {
        return "user-00$id";
      } else if (id < 100) {
        return "user-0$id";
      } else {
        return "user-$id";
      }
    }
    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      String userID = getUserID();
      String displayName = _displayNameFieldKey.currentState?.value;
      String pfp = _pfpFieldKey.currentState?.value;
      String major = _majorFieldKey.currentState?.value;
      String projectedGraduation = _gradFieldKey.currentState?.value;
      String status = _statusFieldKey.currentState?.value;
      usersDB.addUser(
        UniUser.User(
          uid: userID,
          displayName: displayName,
          pfp: pfp,
          major: major,
          projectedGraduation: projectedGraduation,
          status: status,
          friends: friends,
          groupIDs: groupIDs,
          eventIDs: eventIDs,
          interests: interests,
          email: email,
        )
      );
      //Return to previous page
      ref.refresh(userDBProvider);
      ref.read(currentUserProvider.notifier).state = userID;
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
    void onReset() {
      _formKey.currentState?.reset();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create your Profile!"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal:24.0),
        children: [
          Column(
            children:[
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: Text(
                          "Looks like you're new here! Let's get you set up.",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      )
                    ),
                    DisplayNameField(fieldKey: _displayNameFieldKey),
                    PfpField(fieldKey: _pfpFieldKey),
                    MajorField(fieldKey: _majorFieldKey),
                    GradField(fieldKey: _gradFieldKey),
                    StatusField(fieldKey: _statusFieldKey),
                  ]
                )
              ),
              Row(
                children: [
                  SubmitButton(onSubmit: onSubmit),
                  ResetButton(onReset: onReset),
                ]
              )
            ]
          )
        ]
      )
    );
  }
}