import 'package:connectuni/features/user/presentation/user_card_search.dart';
import 'package:flutter/cupertino.dart';
import '../data/user_providers.dart';
import '../domain/user.dart';
import 'other_user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCardWidget extends ConsumerWidget {
  const UserCardWidget({Key? key, this.onSearchPage = false, required this.user}) : super(key: key);
  final bool onSearchPage;
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        onSearchPage
            ? ref.read(recentSearchesProvider.notifier).add(user) : null;
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => OtherUserProfile(user: user,)
          )
        );
      },
      child: UserCardSearch(user: user),
    );
  }
}
