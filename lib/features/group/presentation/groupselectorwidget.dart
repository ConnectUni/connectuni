import 'package:flutter/material.dart';

import '../../user/domain/user.dart';
import '../domain/group.dart';
import '../domain/group_list.dart';

class GroupSelector extends StatefulWidget {
  const GroupSelector({super.key});

  @override
  State<GroupSelector> createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  final List<Group> _allGroups = TempGroupsDB.getAllGroups();
  final List<Group> _selectedGroups = [];
  late User currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 6.0, // gap between adjacent chips
          runSpacing: 6.0, // gap between lines
          children: _allGroups
              .map((group) => ChoiceChip(
                    label: Text(group.groupName),
                    selected: _selectedGroups.contains(group),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedGroups.add(group);
                        } else {
                          _selectedGroups.remove(group);
                        }
                      });
                    },
                  ))
              .toList(),
        ),
        ElevatedButton(
          onPressed: _updateUserGroups,
          child: const Text("Update Groups"),
        )
      ],
    );
  }

  void _updateUserGroups() {
    //i used a cast, not sure if this is the best way to implement
    currentUser.groupIDs = _selectedGroups.cast<String>();
  }
}
