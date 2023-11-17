
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../group/presentation/form-fields/reset_button.dart';
import '../../group/presentation/form-fields/submit_button.dart';
import '../../home/presentation/home.dart';
import '../data/user_providers.dart';
import '../domain/user.dart' as Uni;
import '../domain/user_list.dart';
import 'form-fields/display_name_field.dart';
import 'form-fields/grad_field.dart';
import 'form-fields/major_field.dart';
import 'form-fields/pfp_field.dart';
import 'form-fields/status_field.dart';



class EditUser extends ConsumerWidget {
  final String id;
  static const routeName = '/edit_user';
  EditUser({Key? key, required this.id}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final _displayNameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _pfpFieldKey = GlobalKey<FormBuilderFieldState>();
  final _majorFieldKey = GlobalKey<FormBuilderFieldState>();
  final _gradFieldKey = GlobalKey<FormBuilderFieldState>();
  final _statusFieldKey = GlobalKey<FormBuilderFieldState>();

  final List<Uni.User> friends = [];
  final List<String> groupIDs = [];
  final List<String> eventIDs = [];
  final List<String> interests = [];

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String email = auth.currentUser!.email!;
    final UserList usersDB = ref.watch(userDBProvider);
    Uni.User editUser = usersDB.getUserByID(id);
    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      String userID = editUser.uid;
      String displayName = _displayNameFieldKey.currentState?.value;
      String pfp = _pfpFieldKey.currentState?.value;
      String major = _majorFieldKey.currentState?.value;
      String projectedGraduation = _gradFieldKey.currentState?.value;
      String status = _statusFieldKey.currentState?.value;
      usersDB.updateUser(
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
      );
      //Return to previous page
      ref.refresh(userDBProvider);
      Navigator.pop(context);
    }
    void onReset() {
      _formKey.currentState?.reset();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit your Profile"),
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
                              DisplayNameField(fieldKey: _displayNameFieldKey, currName: editUser.displayName,),
                              PfpField(fieldKey: _pfpFieldKey, currpfp: editUser.pfp),
                              MajorField(fieldKey: _majorFieldKey, currMajor: editUser.major,),
                              GradField(fieldKey: _gradFieldKey, currGrad: editUser.projectedGraduation),
                              StatusField(fieldKey: _statusFieldKey, currStatus: editUser.status,),
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