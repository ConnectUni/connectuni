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
