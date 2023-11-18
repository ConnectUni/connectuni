import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../chat/data/chat_providers.dart';
import '../../chat/domain/chat.dart';
import '../../chat/domain/chat_list.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user_list.dart';
import '../data/group_providers.dart';
import '../domain/group.dart';
import '../domain/group_list.dart';
import '../../message/domain/message.dart';
import 'form-fields/group_description_field.dart';
import 'form-fields/group_image_field.dart';
import 'form-fields/group_name_field.dart';
import 'form-fields/owner_field.dart';
import 'form-fields/reset_button.dart';
import 'form-fields/semyear_field.dart';
import 'form-fields/submit_button.dart';

//Creates a new Group
class AddGroup extends ConsumerWidget {
  AddGroup({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final _groupNameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _semYearFieldKey = GlobalKey<FormBuilderFieldState>();
  final _ownerFieldKey = GlobalKey<FormBuilderFieldState>();
  final _groupImageFieldKey = GlobalKey<FormBuilderFieldState>();
  final _groupDescriptionFieldKey = GlobalKey<FormBuilderFieldState>();

  final List<Message> newMessages = [];
  final List<String> eventIDs = [];
  final List<String> userIDs = [];
  final List<String> interests = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupList groupsDB = ref.watch(groupsDBProvider);
    final UserList usersDB = ref.watch(userDBProvider);
    final String currUser = ref.watch(currentUserProvider);
    final ChatList chatsDB = ref.watch(chatDBProvider);
    int groupId = groupsDB.groupLength() + 1;
    int chatId = chatsDB.chatLength() + 1;
    String getGroupID() {
      if (groupId < 10) {
        return "group-00$groupId";
      } else if (groupId < 100) {
        return "group-0$groupId";
      } else {
        return "group-$groupId";
      }
    }
    String getChatID() {
      if (chatId < 10) {
        return "chat-00$chatId";
      } else if (chatId < 100) {
        return "chat-0$chatId";
      } else {
        return "chat-$chatId";
      }
    }

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      String groupID = getGroupID();
      String groupName = _groupNameFieldKey.currentState?.value;
      String semYear = _semYearFieldKey.currentState?.value;
      String owner = _ownerFieldKey.currentState?.value;
      String groupImage = _groupImageFieldKey.currentState?.value ?? '';
      String groupDescription = _groupDescriptionFieldKey.currentState?.value ?? '';
      String chatID = getChatID();
      groupsDB.addGroup(
        Group(
        groupID: groupID,
        groupName: groupName,
        semYear: semYear,
        owner: owner,
        groupImage: groupImage,
        groupDescription: groupDescription,
        newMessages: newMessages,
        chatID: chatID,
        eventIDs: eventIDs,
        userIDs: userIDs,
        interests: interests,
        )
      );
      chatsDB.addChat(
        Chat(
          chatID: chatID,
          groupID: groupID,
          userIDs: userIDs,
          messageIDs: [],
        )
      );
      //Add the group to the user's list of groups and vice versa.
      usersDB.getUserByID(currUser).groupIDs.add(groupID);
      groupsDB.getGroupById(groupID).userIDs.add(currUser);
      //Return to the previous page
      ref.refresh(groupsDBProvider);
      Navigator.pop(context);

    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Group'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: [
          Column(
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    GroupNameField(fieldKey: _groupNameFieldKey),
                    SemYearField(fieldKey: _semYearFieldKey),
                    OwnerField(fieldKey: _ownerFieldKey),
                    GroupImageField(fieldKey: _groupImageFieldKey),
                    GroupDescriptionField(fieldKey: _groupDescriptionFieldKey),
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
      )
    );
  }
}