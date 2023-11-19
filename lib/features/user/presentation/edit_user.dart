import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/user/presentation/edit_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cu_error.dart';
import '../../cu_loading.dart';
import '../../group/presentation/form-fields/reset_button.dart';
import '../../group/presentation/form-fields/submit_button.dart';
import '../domain/user.dart';
import 'form-fields/display_name_field.dart';
import 'form-fields/grad_field.dart';
import 'form-fields/major_field.dart';
import 'form-fields/pfp_field.dart';
import 'form-fields/status_field.dart';

class EditUser extends ConsumerWidget {
  EditUser({
    super.key,
  });

  static const routeName = '/edit_user';
  final _formKey = GlobalKey<FormBuilderState>();
  final _displayNameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _pfpFieldKey = GlobalKey<FormBuilderFieldState>();
  final _majorFieldKey = GlobalKey<FormBuilderFieldState>();
  final _gradFieldKey = GlobalKey<FormBuilderFieldState>();
  final _statusFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
      data: (allData) =>
          _build(
            context: context,
            currentUser: allData.currentUser,
            ref: ref
          ),
      loading: () => const CULoading(),
      error: (e, st) => CUError(e.toString(), st.toString())
    );
  }

  Widget _build ({
    required BuildContext context,
    required User currentUser,
    required WidgetRef ref
  }) {
    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      String userID = currentUser.uid;
      String displayName = _displayNameFieldKey.currentState?.value;
      String pfp = _pfpFieldKey.currentState?.value;
      String major = _majorFieldKey.currentState?.value;
      String projectedGraduation = _gradFieldKey.currentState?.value;
      String status = _statusFieldKey.currentState?.value;
      String email = currentUser.email;
      User updatedUser = User(
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
        user: updatedUser,
        onSuccess: () {
          Navigator.pop(context);
        },
      );
    }
    void onReset() {
      _formKey.currentState?.reset();
    }

    Widget editUserForm() => ListView(
        padding: const EdgeInsets.symmetric(horizontal:24.0),
        children: [
          Column(
              children:[
                FormBuilder(
                    key: _formKey,
                    child: Column(
                        children: [
                          DisplayNameField(fieldKey: _displayNameFieldKey, currName: currentUser.displayName,),
                          PfpField(fieldKey: _pfpFieldKey, currpfp: currentUser.pfp),
                          MajorField(fieldKey: _majorFieldKey, currMajor: currentUser.major,),
                          GradField(fieldKey: _gradFieldKey, currGrad: currentUser.projectedGraduation),
                          StatusField(fieldKey: _statusFieldKey, currStatus: currentUser.status,),
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
          title: const Text("Edit your Profile"),
        ),
        body: asyncUpdate.when(
          data: (_) => editUserForm(),
          error: (e, st) => CUError(e.toString(), st.toString()),
          loading: () => const CULoading()));
  }
}
