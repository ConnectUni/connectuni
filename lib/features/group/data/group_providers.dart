import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/group.dart';
import 'group_database.dart';

part 'group_providers.g.dart';

@riverpod
GroupDatabase groupDatabase(GroupDatabaseRef ref) {
  return GroupDatabase(ref);
}

@riverpod
Stream<List<Group>> groups(GroupsRef ref) {
  final database = ref.watch(groupDatabaseProvider);
  return database.watchGroups();
}

@riverpod
class FilteredGroups extends _$FilteredGroups {
  bool mounted = true;
  List<Group> groups = [];
  List<Group> results = [];
  List<String> filters = [];
  String query = '';

  @override
  FutureOr<List<Group>> build() async {
    ref.onDispose(() => mounted = false);
    groups = await ref.watch(groupsProvider.future);
    return groups;
  }

  void _updateResults() {
    if (query.isEmpty && filters.isEmpty) {
      results = groups;
    } else {
      results = groups.where((group) {
        if (filters.isNotEmpty) {
          return group.groupName
              .toLowerCase()
              .contains(query.toLowerCase()) && group.interests
              .any((interests) => filters.contains(interests));
        } else {
          return group.groupName
              .toLowerCase()
              .contains(query.toLowerCase());
        }
      }).toList();
    }
    if (mounted) {
      state = AsyncData(results);
    }
  }

  void filterQuery(String input) {
    query = input;
    _updateResults();
  }

  void updateFilters(List<String> filters) {
    this.filters = filters;
    _updateResults();
  }
}
