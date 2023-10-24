import 'package:flutter/material.dart';
import 'package:connectuni/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user_list.dart';
import '../screens/other_user_profile.dart';

class UserCardSearch extends ConsumerWidget {

  const UserCardSearch({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name = user.displayName;
    final UserList usersDB = ref.watch(userDBProvider);
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
                      return OtherUserProfile(user: thisUser);
                    }));
                  },
                ),
              ),
            ],
          )),
    );
  }
}
