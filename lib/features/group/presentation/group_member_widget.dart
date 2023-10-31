import 'package:connectuni/features/user/presentation/other_user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectuni/features/user/domain/user.dart';
import 'package:connectuni/features/group/presentation/group_member_card.dart';

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
