import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../event/data/event_providers.dart';
import '../../event/domain/event_list.dart';
import '../../group/data/group_providers.dart';
import '../../group/domain/group.dart';
import '../../group/domain/group_list.dart';
import '../../group/presentation/form-fields/reset_button.dart';
import '../../group/presentation/form-fields/submit_button.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart' as Uni;
import '../../user/domain/user_list.dart';
import '../data/interests.dart';
import 'form-fields/interests_field.dart';


class EditInterest extends ConsumerWidget {
  final String id;
  final String type;
  static const routeName = '/edit_interest';
  EditInterest({Key? key, required this.id, required this.type}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final _interestsFieldKey = GlobalKey<FormBuilderFieldState>();
  List<String> thisInterests = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserList usersDB = ref.watch(userDBProvider);
    final GroupList groupsDB = ref.watch(groupsDBProvider);
    final EventList eventsDB = ref.watch(eventsDBProvider);

    if(type == "user") {
      //Get User Interests
      thisInterests = usersDB.getUserByID(id).interests;
    } else if(type == "group") {
      //Get Group Interests
      thisInterests = groupsDB.getGroupById(id).interests;
    } else if(type == "event") {
      //Get Event Interests
      thisInterests = eventsDB.getEventById(id).interests;
    }

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      List<String> interestsUpdate = _interestsFieldKey.currentState?.value;

      if(type == "user") {
        //Get User Data
        Uni.User editUser = usersDB.getUserByID(id);
        //Update User Interests
        usersDB.updateUser(
          uid: editUser.uid,
          displayName: editUser.displayName,
          pfp: editUser.pfp,
          major: editUser.major,
          projectedGraduation: editUser.projectedGraduation,
          status: editUser.status,
          friends: editUser.friends,
          groupIDs: editUser.groupIDs,
          eventIDs: editUser.eventIDs,
          interests: interestsUpdate,
          email: editUser.email,
          password: 'temp',
        );
      } else if(type == "group") {
        //Update Group Interests
        //groupsDB.updateGroupInterests(id, interests);
        Group editGroup = groupsDB.getGroupById(id);
        groupsDB.updateGroup(
          groupID: editGroup.groupID,
          groupName: editGroup.groupName,
          semYear: editGroup.semYear,
          owner: editGroup.owner,
          groupImage: editGroup.groupImage,
          groupDescription: editGroup.groupDescription,
          newMessages: editGroup.newMessages,
          chatID: editGroup.chatID,
          eventIDs: editGroup.eventIDs,
          userIDs: editGroup.userIDs,
          interests: interestsUpdate,
        );
      } else if(type == "event") {
        //Update Event Interests
        //eventsDB.updateEventInterests(id, interests);
      }
      //Return to previous page
      ref.refresh(groupsDBProvider);
      ref.refresh(userDBProvider);
      ref.refresh(interestsProvider);
      Navigator.pop(context);
    }
    void onReset() {
      _formKey.currentState?.reset();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Interests"),
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
                              InterestsField(fieldKey: _interestsFieldKey, currInterests: thisInterests),
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