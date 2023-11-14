import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/user.dart';
import '../domain/user_list.dart';

final userDBProvider = Provider<UserList>((ref) { return UserList(mockUsers); });
final currentUserProvider = StateProvider<String>((ref) => 'user-000');
/*
 * These are the state providers that will be used to check the selected
 * interests and the search query.
 */
final selectedFiltersProvider = StateProvider<List<String>?>((ref) => []);
final searchQueryProvider = StateProvider<String?>((ref) => "");

/*
 * This provider will be used to find the users that are not friends with the
 * current user
 */
final notUsersFriendsProvider = Provider<List<User>?>((ref) {
  final usersDB = ref.watch(userDBProvider);
  final User currentUser = usersDB.getUserByID(ref.read(currentUserProvider));
  final notFriends = usersDB
      .getUsers()
      .where((user) => !currentUser.friends.contains(user))
      .toList();

  return notFriends;
});

/*
 * This provider will be used to filter the users based on the selected
 * interests and the search query from the providers above.
 */
final filteredUsers = Provider<List<User>?>((ref) {
  final filters = ref.watch(selectedFiltersProvider);
  final users = ref.watch(notUsersFriendsProvider);
  final query = ref.watch(searchQueryProvider);
  final suggestions = users?.where((user) {
    if(filters!.isNotEmpty) {
      return user.displayName.toLowerCase().contains(query!.toLowerCase()) && user.interests.any((interest) => filters.contains(interest));
    } else {
      return user.displayName.toLowerCase().contains(query!.toLowerCase());
    }
  }).toList();

  return suggestions;
});

class RecentSearchesNotifier extends StateNotifier<List<User>?> {
  RecentSearchesNotifier() : super([]);

  void add(User user) {
    if (state!.contains(user)) {
      state!.remove(user);
    }
    state!.insert(0, user);
    if (state!.length > 5) {
      state!.removeLast();
    }
  }

  void clear() {
    state = [];
  }
}

final recentSearchesProvider = StateNotifierProvider<RecentSearchesNotifier, List<User>?>((ref) {
  return RecentSearchesNotifier();
});

final isSearchFilledProvider = Provider<bool>((ref) {
  final query = ref.watch(searchQueryProvider);

  return query!.isNotEmpty;
});
