import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectuni/features/user/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/user_providers.dart';
import 'other_user_profile.dart';

class UserCardWidget extends ConsumerWidget {
  const UserCardWidget({Key? key, this.onSearchPage = false, required this.user}) : super(key: key);

  final bool onSearchPage;
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
        data: (allData) =>
            _build(
              context: context,
              users: allData.users,
              ref: ref,
            ),
        loading: () => const CULoading(),
        error: (e, st) => CUError(e.toString(), st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required List<User> users,
    required WidgetRef ref
  }) {
    UserCollection userCollection = UserCollection(users);
    User thisUser = userCollection.getUser(user.uid);

    return Padding(
      padding: const EdgeInsets.all(3.5),
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                onSearchPage
                    ? ref.read(filteredUsersProvider.notifier).addRecent(user) : null;
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => OtherUserProfile(user: user,)
                    )
                );
              },
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
                  print('message user');
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
