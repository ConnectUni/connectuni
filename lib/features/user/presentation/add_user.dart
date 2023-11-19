import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';
import 'package:connectuni/features/user/presentation/edit_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../group/presentation/form-fields/reset_button.dart';
import '../../group/presentation/form-fields/submit_button.dart';
import '../../home/presentation/home.dart';
import '../data/user_providers.dart';
import '../domain/user.dart';
import 'form-fields/display_name_field.dart';
import 'form-fields/grad_field.dart';
import 'form-fields/major_field.dart';
import 'form-fields/pfp_field.dart';
import 'form-fields/status_field.dart';

class AddUser extends ConsumerWidget {
  AddUser({
    super.key,
    required this.email,
  });
  final String email;

  static const routeName = '/add_user';
  final _formKey = GlobalKey<FormBuilderState>();
  final _displayNameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _pfpFieldKey = GlobalKey<FormBuilderFieldState>();
  final _majorFieldKey = GlobalKey<FormBuilderFieldState>();
  final _gradFieldKey = GlobalKey<FormBuilderFieldState>();
  final _statusFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<User>> asyncValue = ref.watch(usersProvider);
    return asyncValue.when(
        data: (users) =>
            _build(
                context: context,
                users: users,
                ref: ref
            ),
        loading: () => const CULoading(),
        error: (e, st) => CUError(e.toString(), st.toString()));
  }

  Widget _build ({
    required BuildContext context,
    required List<User> users,
    required WidgetRef ref
  }) {
    UserCollection userCollection = UserCollection(users);

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      String userID = userCollection.getNewID();
      String displayName = _displayNameFieldKey.currentState?.value;
      String pfp = _pfpFieldKey.currentState?.value;
      String major = _majorFieldKey.currentState?.value;
      String projectedGraduation = _gradFieldKey.currentState?.value;
      String status = _statusFieldKey.currentState?.value;
      User user = User(
        uid: userID,
        displayName: displayName,
        pfp: pfp,
        major: major,
        projectedGraduation: projectedGraduation,
        status: status,
        friends: [],
        groupIDs: [],
        eventIDs: [],
        interests: [],
        email: email,
        ///REMOVE THIS BELOW AFTER WE REMOVE ALL PASSWORDS FROM USER DATA
      );
      ref.read(editUserControllerProvider.notifier).updateUser(
          user: user,
          onSuccess: () {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          },
      );
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    Widget addUserForm() => ListView(
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
    );

    AsyncValue asyncUpdate = ref.watch(editUserControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create your Profile!"),
      ),
        body: asyncUpdate.when(
          data: (_) => addUserForm(),
          error: (e, st) => CUError(e.toString(), st.toString()),
          loading: () => const CULoading()));
  }
}
