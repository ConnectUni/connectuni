import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/chat_database.dart';
import '../data/chat_providers.dart';
import '../domain/chat.dart';

part 'edit_chat_controller.g.dart';

@riverpod
class EditChatController extends _$EditChatController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  // Invoked to add a new chat or edit an existing one.
  Future<void> updateChat({
    required Chat chat,
    required VoidCallback onSuccess,
  }) async {
    ChatDatabase chatDatabase = ref.watch(chatDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => chatDatabase.setChat(chat));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}

