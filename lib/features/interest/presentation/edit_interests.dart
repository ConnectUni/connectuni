import 'package:connectuni/features/all_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cu_error.dart';
import '../../cu_loading.dart';
import '../../event/domain/event.dart';
import '../../event/domain/event_collection.dart';
import '../../group/domain/group.dart';
import '../../group/domain/group_collection.dart';
import '../../group/presentation/edit_group_controller.dart';
import '../../group/presentation/form-fields/reset_button.dart';
import '../../group/presentation/form-fields/submit_button.dart';
import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';
import '../../user/presentation/edit_user_controller.dart';
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
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
      data: (allData) =>
          _build(
            context: context,
            users: allData.users,
            groups: allData.groups,
            events: allData.events,
            ref: ref
          ),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading());
  }
  Widget _build ({
    required BuildContext context,
    required List<User> users,
    required List<Group> groups,
    required List<SingleEvent> events,
    required WidgetRef ref
  }) {
    UserCollection userCollection = UserCollection(users);
    GroupCollection groupCollection = GroupCollection(groups);
    EventCollection eventCollection = EventCollection(events);

    if(type == "user") {
      //Get User Interests
      thisInterests = userCollection.getUser(id).interests;
    } else if(type == "group") {
      //Get Group Interests
      thisInterests = groupCollection.getGroup(id).interests;
    } else if(type == "event") {
      //Get Event Interests
      thisInterests = eventCollection.getEvent(id).interests;
    }

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      List<String> interestsUpdate = _interestsFieldKey.currentState?.value;

      if(type == "user") {
        //Get User Data
        User editUser = userCollection.getUser(id);
        //Update User Interests
        User updatedUser = User(
          uid: editUser.uid,
          displayName: editUser.displayName,
          pfp: editUser.pfp,
          major: editUser.major,
          projectedGraduation: editUser.projectedGraduation,
          status: editUser.status,
          friends: editUser.friends,
          sentFriendRequests: editUser.sentFriendRequests,
          receivedFriendRequests: editUser.receivedFriendRequests,
          groupIDs: editUser.groupIDs,
          eventIDs: editUser.eventIDs,
          interests: interestsUpdate,
          email: editUser.email,
        );
        ref.read(editUserControllerProvider.notifier).updateUser(
            user: updatedUser,
            onSuccess: () {
              Navigator.pop(context);
              print('User updated successfully');
              },
          );
      } else if(type == "group") {
        //Update Group Interests
        //groupsDB.updateGroupInterests(id, interests);
        Group editGroup = groupCollection.getGroup(id);
        Group updatedGroup = Group(
          groupID: editGroup.groupID,
          groupName: editGroup.groupName,
          semYear: editGroup.semYear,
          professor: editGroup.professor,
          owner: editGroup.owner,
          groupImage: editGroup.groupImage,
          groupDescription: editGroup.groupDescription,
          newMessages: editGroup.newMessages,
          chatID: editGroup.chatID,
          eventIDs: editGroup.eventIDs,
          userIDs: editGroup.userIDs,
          interests: interestsUpdate,
        );
        ref.read(editGroupControllerProvider.notifier).updateGroup(
          group: updatedGroup,
          onSuccess: () {
            print('Group updated successfully');
            Navigator.pop(context);
          },
        );
      } else if(type == "event") {
        //Update Event Interests
        //eventsDB.updateEventInterests(id, interests);
      }
      //Return to previous page
      ref.refresh(interestsProvider);
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
