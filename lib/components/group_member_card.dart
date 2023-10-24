import 'package:flutter/material.dart';
import '../model/user.dart';

class GroupMemberCard extends StatelessWidget {
  const GroupMemberCard({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(user.pfp),
        ),
        title: Text(user.displayName),
      ),
    );
  }
}
