import 'package:connectuni/features/user/presentation/other_user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectuni/features/user/domain/user.dart';
import 'package:flutter/material.dart';

class GroupMemberWidget extends StatelessWidget {
  const GroupMemberWidget({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => OtherUserProfile(user: user)
            ),
          );
        },
        leading: CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(user.pfp),
        ),
        title: Text(user.displayName),
      ),
    );
  }
}
