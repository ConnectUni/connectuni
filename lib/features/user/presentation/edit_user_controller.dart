import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/user_database.dart';
import '../data/user_providers.dart';
import '../domain/user.dart';

part 'edit_user_controller.g.dart';

@riverpod
class EditUserController extends _$EditUserController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  // Invoked to add a new user or edit an existing one.
  Future<void> updateUser({
    required User user,
    required VoidCallback onSuccess,
  }) async {
    UserDatabase userDatabase = ref.watch(userDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => userDatabase.setUser(user));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }

  Future<void> deleteUser({
    required User user,
    required VoidCallback onSuccess,
  }) async {
    UserDatabase userDatabase = ref.watch(userDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => userDatabase.deleteUser(user));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}
