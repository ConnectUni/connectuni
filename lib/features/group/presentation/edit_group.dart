import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/group/domain/group_collection.dart';
import 'package:connectuni/features/group/presentation/edit_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../domain/group.dart';
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
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
        data: (allData) =>
            _build(
                context: context,
                groups: allData.groups,
                ref: ref
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Text(e.toString())
    );
  }
  Widget _build ({
    required BuildContext context,
    required List<Group> groups,
    required WidgetRef ref
  }) {
    GroupCollection groupCollection = GroupCollection(groups);
    Group uneditedGroup = groupCollection.getGroup(id);

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      String groupID = id;
      String groupName = _groupNameFieldKey.currentState?.value;
      String semYear = _semYearFieldKey.currentState?.value;
      String owner = _ownerFieldKey.currentState?.value;
      String groupImage = _groupImageFieldKey.currentState?.value ?? '';
      String groupDescription = _groupDescriptionFieldKey.currentState?.value ?? '';
      Group editedGroup = Group(
            groupID: groupID,
            groupName: groupName,
            semYear: semYear,
            owner: owner,
            groupImage: groupImage,
            groupDescription: groupDescription,
            newMessages: uneditedGroup.newMessages,
            chatID: uneditedGroup.chatID,
            eventIDs: uneditedGroup.eventIDs,
            userIDs: uneditedGroup.userIDs,
            interests: uneditedGroup.interests,
      );
      ref.read(editGroupControllerProvider.notifier).updateGroup(
        group: editedGroup,
        onSuccess: () {
          Navigator.pop(context);
        },
      );
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    Widget editGroupForm() => ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                  children: [
                    GroupNameField(fieldKey: _groupNameFieldKey, currName: uneditedGroup.groupName),
                    SemYearField(fieldKey: _semYearFieldKey, currSemYear: uneditedGroup.semYear),
                    OwnerField(fieldKey: _ownerFieldKey, currOwner: uneditedGroup.owner),
                    GroupImageField(fieldKey: _groupImageFieldKey, currImage: uneditedGroup.groupImage),
                    GroupDescriptionField(fieldKey: _groupDescriptionFieldKey, currDesc: uneditedGroup.groupDescription),
                  ]
              ),
            ),
            Row(
                children: [
                  SubmitButton(onSubmit: onSubmit),
                  ResetButton(onReset: onReset),
                ]
            )
          ],
        ),
      ],
    );

    AsyncValue asyncUpdate = ref.watch(editGroupControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Group'),
      ),
        body: asyncUpdate.when(
          data: (_) => editGroupForm(),
          error: (e, st) => CUError(e.toString(), st.toString()),
          loading: () => const CULoading()));
  }
}
