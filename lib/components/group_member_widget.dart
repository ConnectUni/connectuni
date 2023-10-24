import 'package:connectuni/screens/other_user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectuni/model/user.dart';
import 'package:connectuni/components/group_member_card.dart';

class GroupMemberWidget extends StatelessWidget {
  const GroupMemberWidget({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => OtherUserProfile(user: user)
          ),
        );
      },
      child: GroupMemberCard(user: user),
    );
  }
}
