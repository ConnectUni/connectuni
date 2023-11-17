import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/group_database.dart';
import '../data/group_providers.dart';
import '../domain/group.dart';

part 'edit_group_controller.g.dart';

@riverpod
class EditGroupController extends _$EditGroupController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  // Invoked to add a new group or edit an existing one.
  Future<void> updateGroup({
    required Group group,
    required VoidCallback onSuccess,
  }) async {
    GroupDatabase groupDatabase = ref.watch(groupDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => groupDatabase.setGroup(group));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }

  Future<void> deleteGroup({
    required Group group,
    required VoidCallback onSuccess,
  }) async {
    GroupDatabase groupDatabase = ref.watch(groupDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => groupDatabase.deleteGroup(group));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}
