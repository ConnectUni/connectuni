import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/message_database.dart';
import '../data/message_providers.dart';
import '../domain/message.dart';

part 'edit_message_controller.g.dart';

@riverpod
class EditMessageController extends _$EditMessageController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  // Invoked to add a new message or edit an existing one.
  Future<void> updateMessage({
    required Message message,
    required VoidCallback onSuccess,
  }) async {
    MessageDatabase messageDatabase = ref.watch(messageDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => messageDatabase.setMessage(message));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }

  Future<void> deleteMessage({
    required Message message,
    required VoidCallback onSuccess,
  }) async {
    MessageDatabase messageDatabase = ref.watch(messageDatabaseProvider);
    final newState = await AsyncValue.guard(() => messageDatabase.deleteMessage(message));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}
