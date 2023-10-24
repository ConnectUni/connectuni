import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/user_list.dart';

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
                    Text("${thisUser.major}\n${thisUser.projectedGraduation}"),
                trailing: IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () {
                    // TODO Add functionality to message user
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OtherUserProfile(uid: thisUser.uid);
                    }));
                  },
                ),
              ),
            ],
          )),
    );
  }
}
