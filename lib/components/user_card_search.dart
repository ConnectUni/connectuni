import 'package:connectuni/screens/other_user_profile.dart';
import 'package:flutter/material.dart';

import 'package:connectuni/model/user.dart';
import '../model/userList.dart';

class UserCardSearch extends StatelessWidget {
  const UserCardSearch({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    User thisUser = usersDB.getUserByName(name);

    return Padding(
      padding: const EdgeInsets.all(3.5),
      child: Card(
          elevation: 8,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(thisUser.pfp),
                ),
                title: Text(thisUser.displayName,
                    style: Theme.of(context).textTheme.titleLarge),
                subtitle:
                    Text("${thisUser.major}\n${thisUser.projectedGraduation}"),
                trailing: IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () {
                    // TODO Add functionality to message user
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return OtherUserProfile(uid: thisUser.uid);
                        })
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
