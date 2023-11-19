import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/group/presentation/edit_group_controller.dart';
import 'package:connectuni/features/group/presentation/group_member_widget.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectuni/features/group/domain/group.dart';
import '../../home/presentation/home.dart';
import '../../interest/presentation/edit_interests.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../../user/domain/user_list.dart';
import '../../user/presentation/edit_user_controller.dart';
import 'edit_group.dart';

/// Information page for a specific group that displays the group members as well as a description of the selected group.
/// There is an icon at the upper right-hand corner for more statistic-related properties of the group.
class GroupInfo extends ConsumerStatefulWidget {
  const GroupInfo({
    super.key,
    required this.group,
  });

  final Group? group;

  @override
  ConsumerState<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends ConsumerState<GroupInfo> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<User> asyncValue = ref.watch(currentUserProvider);
    return asyncValue.when(
        data: (user) => _build(
          context: context,
          group: widget.group!,
          currentUser: user,
          ref: ref,
        ),
        error: (e,st) => CUError(e.toString(), st.toString()),
        loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required Group group,
    required User currentUser,
    required WidgetRef ref
  }) {

    Widget buildPopupDialog(BuildContext context) {
      return AlertDialog(
        title: const Text('Sad to see you leave!'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("You have left the group."),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    }

    List<Widget> listMembers = [
      //TODO: Implement functionality and make cards interactive rather than simply visual. || 11/17/23: is this done?
      const Padding(
        padding: EdgeInsets.only(top: 20, left: 20),
        child: Text(
          'Members:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ...group
                .userIDs.map((userId) => TempUsersDB.getUserByID(userId)).toList()
                .map((user) => GroupMemberWidget(user: user)),
          ],
        ),
      ),
      const Divider(
        height: 7,
        thickness: 2,
        indent: 20,
        endIndent: 20,
      )
    ];

    List<Widget> showGroupDesc = [
      const Padding(
        padding: EdgeInsets.only(top: 20, left: 20),
        child: Text(
          'Information:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        child: Text(
          group.groupDescription,
          softWrap: true,
        ),
      ),
      const Divider(
        height: 7,
        thickness: 2,
        indent: 20,
        endIndent: 20,
        color: Colors.black,
      ),
      const Padding(
        padding: EdgeInsets.only(top: 20, left: 20),
        child: Text(
          'Interests:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      if(group.interests.isEmpty)
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: ListTile(
            title: Center(
                child: Text("This Group has no Interests.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold))),
            textColor: Colors.white,
            tileColor: FlexColor.deepBlueLightSecondary,
          ),
        ),
      Column(children: [
        ...group.interests.map(
              (interest) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Center(
                  child: Text(interest,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold))),
              textColor: Colors.white,
              tileColor: FlexColor.deepBlueLightTertiary,
            ),
          ),
          // textAlign: TextAlign.left,
        ),
        if (group.userIDs.contains(currentUser))
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                  return EditInterest(id: group.groupID, type: "group");
                }));
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(FlexColor.deepBlueLightSecondary),
                foregroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Edit Interests'),
            ),
          ),
      ]
      ),
      const Divider(
        height: 7,
        thickness: 2,
        indent: 20,
        endIndent: 20,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('${group.groupName} | ${group.owner}'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.badge_outlined,
              semanticLabel: 'Information',
            ),
            onPressed: () {
              print('Go to Information page'); // 10/20/23: Is this not the information page? do we need this icon? 11/17/23: yah idk what this is for
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ...listMembers,
          ...showGroupDesc,
          // ADD INTERESTS HERE
          //Display a button to leave the group if the user is in the group.
          if (group.userIDs.contains(currentUser.uid))
            Padding(
                padding: const EdgeInsets.all(10.0),
                //TODO: Make this button conditional on whether or not the user is in the group.
                child: Column(children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EditGroup(id: group.groupID);
                      }));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          FlexColor.greenLightPrimary),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text('EDIT THIS GROUP'),
                  ),
                  TextButton(
                    onPressed: () {
                      //Remove the user from the group's database. Then Refresh the group's database.
                      group.userIDs.remove(currentUser.uid);
                      ref.read(editGroupControllerProvider.notifier).updateGroup(
                        group: group,
                        onSuccess: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomePage.routeName, (route) => false);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                buildPopupDialog(context),
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(FlexColor.redLightPrimary),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text('LEAVE THIS GROUP'),
                  ),
                ])),
          //Display a button to join the group if the user is not in the group.
          if (!group.userIDs.contains(currentUser.uid))
            Padding(
              padding: const EdgeInsets.all(10.0),
              //TODO: Make this button conditional on whether or not the user is in the group.
              child: TextButton(
                onPressed: () {
                  //Add the user from the group's database. Then Refresh the group's database.
                  group.userIDs.add(currentUser.uid);
                  //TODO: Add groupId from user.
                  currentUser.groupIDs.add(group.groupID);
                  ref.read(editGroupControllerProvider.notifier).updateGroup(group: group, onSuccess: () {});
                  ref.read(editUserControllerProvider.notifier).updateUser(user: currentUser, onSuccess: () {});
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('JOIN THIS GROUP'),
              ),
            ),
        ],
      ),
    ); //Scaffold
  } //build
} //HomePage
