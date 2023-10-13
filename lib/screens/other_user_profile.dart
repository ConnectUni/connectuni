import 'package:flutter/material.dart';

import '../model/user.dart';
import '../model/userList.dart';

class OtherUserProfile extends StatelessWidget {
  const OtherUserProfile({Key? key, required this.uid}) : super(key: key);

  final String uid;

  bool isFriend(User user) {
    if (currentUser.friends.contains(user)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    User thisUser = usersDB.getUserByID(uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(thisUser.displayName),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.message,
              semanticLabel: 'message',
            ),
            onPressed: () {
              // TODO Add functionality to message user
            },
          ),
         isFriend(thisUser) ?
              IconButton(
                  onPressed: () {
                    // TODO Add functionality to remove friend
                  },
                  icon: const Icon(
                    Icons.person_remove,
                    semanticLabel: 'remove friend',
                  ),
              ) :
              IconButton(
                  onPressed: () {
                    // TODO Add functionality to add friend
                  },
                  icon: const Icon(
                    Icons.person_add,
                    semanticLabel: 'add friend',
                  )
              )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(thisUser.pfp),
              )
            ],
          ),
          Column(
              children: [
                Text(
                  'Major: ${thisUser.major}',
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  'Projected Grad: ${thisUser.projectedGraduation}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ]
          ),
        ],
      )
    );
  }
}
