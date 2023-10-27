import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../features/group/data/group_providers.dart';
import '../../features/group/domain/group.dart';
import '../../features/group/domain/group_list.dart';
import 'form-fields/group_description_field.dart';
import 'form-fields/group_image_field.dart';
import 'form-fields/group_name_field.dart';
import 'form-fields/owner_field.dart';
import 'form-fields/reset_button.dart';
import 'form-fields/semyear_field.dart';
import 'form-fields/submit_button.dart';

class EditGroup extends ConsumerWidget {
  final String id;
  EditGroup({Key? key, required this.id}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  final _groupNameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _semYearFieldKey = GlobalKey<FormBuilderFieldState>();
  final _ownerFieldKey = GlobalKey<FormBuilderFieldState>();
  final _groupImageFieldKey = GlobalKey<FormBuilderFieldState>();
  final _groupDescriptionFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupList groupsDB = ref.watch(groupsDBProvider);
    Group editGroup = groupsDB.getGroupById(id);

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      String groupID = id;
      String groupName = _groupNameFieldKey.currentState?.value;
      String semYear = _semYearFieldKey.currentState?.value;
      String owner = _ownerFieldKey.currentState?.value;
      String groupImage = _groupImageFieldKey.currentState?.value ?? '';
      String groupDescription =
          _groupDescriptionFieldKey.currentState?.value ?? '';
      groupsDB.updateGroup(
        groupID: groupID,
        groupName: groupName,
        semYear: semYear,
        owner: owner,
        groupImage: groupImage,
        groupDescription: groupDescription,
        newMessages: editGroup.newMessages,
        chatID: editGroup.chatID,
        eventIDs: editGroup.eventIDs,
        userIDs: editGroup.userIDs,
        interests: editGroup.interests,
      );
      //Return to the previous page
      ref.refresh(groupsDBProvider);
      Navigator.pop(context);
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Group'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            Column(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(children: [
                    GroupNameField(
                        fieldKey: _groupNameFieldKey,
                        currName: editGroup.groupName),
                    SemYearField(
                        fieldKey: _semYearFieldKey,
                        currSemYear: editGroup.semYear),
                    OwnerField(
                        fieldKey: _ownerFieldKey, currOwner: editGroup.owner),
                    GroupImageField(
                        fieldKey: _groupImageFieldKey,
                        currImage: editGroup.groupImage),
                    GroupDescriptionField(
                        fieldKey: _groupDescriptionFieldKey,
                        currDesc: editGroup.groupDescription),
                  ]),
                ),
                Row(children: [
                  SubmitButton(onSubmit: onSubmit),
                  ResetButton(onReset: onReset),
                ])
              ],
            ),
          ],
        ));
  }
}
