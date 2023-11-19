import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../domain/group.dart';
import '../domain/group_list.dart';

//Provider that gives access to the total groups database.
final groupsDBProvider = StateProvider<GroupList>((ref) { return GroupList(allGroups); });

final groupsIDProvider = StateProvider<int>((ref) { return GroupList(allGroups).groupLength(); });

/*
 * These are the state providers that will be used to check the selected
 * interests and the search query.
 */
final selectedFiltersProvider = StateProvider<List<String>?>((ref) => []);
final searchQueryProvider = StateProvider<String?>((ref) => "");

/*
 * This provider will be used to find the groups that the current user is not
 * a part of.
 */
final notUsersGroupsProvider = Provider<List<Group>?>((ref) {
  final groupsDB = ref.watch(groupsDBProvider);
  final usersDB = ref.watch(userDBProvider);
  final User currentUser = usersDB.getUserByID(ref.read(currentUserProvider));
  final notGroups = groupsDB
      .getAllGroups()
      .where((group) => !currentUser.groupIDs.contains(group.groupID))
      .toList();

  return notGroups;
});

/*
 * This provider will be used to filter the groups based on the selected
 * interests and the search query from the providers above.
 */
final filteredGroups = Provider<List<Group>?>((ref) {
  final filters = ref.watch(selectedFiltersProvider);
  final groups = ref.watch(groupsDBProvider).getAllGroups();
  final query = ref.watch(searchQueryProvider);
  final suggestions = groups.where((group) {
    if(filters!.isNotEmpty) {
      return group.groupName.toLowerCase().contains(query!.toLowerCase()) && group.interests.any((interest) => filters.contains(interest));
    } else {
      return group.groupName.toLowerCase().contains(query!.toLowerCase());
    }
  }).toList();

  return suggestions;
});

final isSearchFilledProvider = Provider<bool>((ref) {
  final query = ref.watch(searchQueryProvider);

  return query!.isNotEmpty;
});
