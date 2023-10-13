import 'package:connectuni/components/user_card_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../model/userList.dart';
import '../screens/other_user_profile.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    User thisUser = usersDB.getUserByID(id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => OtherUserProfile(uid: thisUser.uid)
          )
        );
      },
      child: UserCardSearch(name: thisUser.displayName)
    );
  }
}
