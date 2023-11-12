import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/user_providers.dart';
import '../../group/data/group_providers.dart';
import '../../group/domain/group.dart';
import '../../group/domain/group_list.dart';
import '../domain/user.dart';
import '../domain/user_list.dart';

class GroupSelector extends ConsumerStatefulWidget {
  const GroupSelector({super.key});

  @override
  ConsumerState<GroupSelector> createState() => _GroupSelectorState();
}

class _GroupSelectorState extends ConsumerState<GroupSelector> {

  @override
  Widget build(BuildContext context) {
    final GroupList groupsDB = ref.watch(groupsDBProvider);
    final List<Group> allGroups = groupsDB.getAllGroups();
    final List<Group> selectedGroups = [];
    final UserList userList = ref.watch(userDBProvider);
    final User currentUser = userList.getUserByID(ref.watch(currentUserProvider));
    void updateUserGroups() {
      //i used a cast, not sure if this is the best way to implement
      currentUser.groupIDs = selectedGroups.cast<String>();
    }
    return Column(
      children: [
        Wrap(
          spacing: 6.0, // gap between adjacent chips
          runSpacing: 6.0, // gap between lines
          children: allGroups.map((group) => ChoiceChip(
            label: Text(group.groupName),
            selected: selectedGroups.contains(group),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  selectedGroups.add(group);
                } else {
                  selectedGroups.remove(group);
                }
              });
            },
          )).toList(),
        ),
        ElevatedButton(
          onPressed: updateUserGroups,
          child: const Text("Update Groups"),
        )
      ],
    );
  }


}