import 'package:flutter/material.dart';

import 'package:connectuni/model/user.dart';

class UserCardSearch extends StatelessWidget {
  const UserCardSearch({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.5),
      child: Card(
          elevation: 8,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(user.pfp),
                ),
                title: Text(user.displayName,
                    style: Theme.of(context).textTheme.titleLarge),
                subtitle:
                    Text("${user.major}\n${user.projectedGraduation}"),
              ),
            ],
          )),
    );
  }
}
