import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/group/data/group_providers.dart';
import 'package:connectuni/features/group/domain/group_collection.dart';
import 'package:connectuni/features/user/domain/user.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import '../../all_data_provider.dart';
import '../../cu_error.dart';
import '../../group/domain/group.dart';
import '../../group/presentation/add_group.dart';
import '../data/user_providers.dart';
import 'edit_user.dart';
import 'friend_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///  Profile Page that the User sees when they click the Navbar Profile icon.

class CurrentUserProfilePage extends ConsumerStatefulWidget {
  const CurrentUserProfilePage({super.key});

  @override
  CurrentUserProfilePageState createState() => CurrentUserProfilePageState();
}

class CurrentUserProfilePageState
    extends ConsumerState<CurrentUserProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);

    return asyncValue.when(
        data: (allData) => _build(
              context: context,
              currentUser: allData.currentUser,
              groups: allData.groups,
            ),
        loading: () => const CULoading(),
        error: (e, st) => CUError(e.toString(), st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required User currentUser,
    required List<Group> groups,
  }) {
    GroupCollection groupCollection = GroupCollection(groups);

    /// This displays the user information at the top of the profile page.
    Widget userInfo() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(currentUser.pfp),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    currentUser.displayName,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Major: ${currentUser.major}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Projected Grad: ${currentUser.projectedGraduation}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditUser();
                        }));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            FlexColor.deepBlueLightTertiary),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

    /// This portion of the code is for the Interests section of the Profile Page.
    List<Widget> userInterests = [
      const Text(
        "Your Interests:",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
      if (currentUser.interests.isEmpty)
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: ListTile(
            title: Center(
                child: Text("Looks like you don't have any interests!",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            textColor: Colors.white,
            tileColor: FlexColor.bigStoneDarkPrimary,
          ),
        ),
      Column(children: [
        //TODO: Implement functionality and make cards interactive rather than simply visual.
        ...currentUser.interests.map(
          (interest) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Center(
                  child: Text(interest,
                      style: const TextStyle(fontWeight: FontWeight.bold))),
              textColor: Colors.white,
              tileColor: FlexColor.bigStoneDarkPrimary,
            ),
          ),
          // textAlign: TextAlign.left,
        ),
        //TODO: Implement interests section here.
        Column(
          children: [
            //TODO: Implement functionality and make cards interactive rather than simply visual.
            ...currentUser.interests.map(
              (interest) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Center(
                    child: Text(interest,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  textColor: Colors.white,
                  tileColor: FlexColor.bigStoneDarkPrimary,
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: ListTile(
            title: Center(
                child: Text("Add an interest.",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            textColor: Colors.white,
            tileColor: Colors.black54,
          ),
        ),
      ]), //Gallery
      const Divider(
        height: 7,
        thickness: 2,
        indent: 20,
        endIndent: 20,
      )
    ];

    /// This displays the Courses section of the Profile Page.
    Widget userCourses() => Container(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //GroupCardView(name: "ICS 466"),
              //GroupCardView(name: "ICS 312"),
              const Text(
                "Your Courses:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Column(children: [
                ...groupCollection.getGroups(currentUser.groupIDs).map(
                      (group) => Card(
                        elevation: 8,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(group.groupName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 15.0, top: 5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                      Text("${group.semYear} | ${group.owner}"),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 15.0, top: 2.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${group.userIDs.length} people"),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () {
                                      /// Remove the user from the group's database.
                                      group.userIDs.remove(currentUser.uid);
                                      currentUser.groupIDs
                                          .remove(group.groupID);
                                      ref.refresh(allDataProvider);

                                      /// Display "You have left the group" modal.
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            buildPopupDialog(context),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.redAccent),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: const Text('LEAVE'),
                                  ),
                                )),
                            const SizedBox(height: 10)
                          ],
                        ),
                      ),
                    ),
              ]),
            ],
          ),
        );

    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.people,
                semanticLabel: 'friends list',
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FriendsList();
                }));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                semanticLabel: 'settings',
              ),
              onPressed: () {
                //Routes to the Settings Page.
                Navigator.restorablePushNamed(context, '/settings',
                    arguments: '/');
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            userInfo(),
            const Divider(
              height: 7,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [...userInterests, userCourses()],
              ),
            )
          ],
        ));
  }
}
