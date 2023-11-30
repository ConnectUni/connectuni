import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/notification_database.dart';
import '../data/notification_providers.dart';
import '../domain/notification.dart';

part 'edit_notification_controller.g.dart';

@riverpod
class EditNotificationController extends _$EditNotificationController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  // Invoked to add a new notification or edit an existing one.
  Future<void> updateNotification({
    required Notification notification,
    required VoidCallback onSuccess,
  }) async {
    NotificationDatabase notificationDatabase = ref.watch(notificationDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => notificationDatabase.setNotification(notification));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }

  Future<void> deleteNotification({
    required Notification notification,
    required VoidCallback onSuccess,
  }) async {
    NotificationDatabase notificationDatabase = ref.watch(notificationDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => notificationDatabase.deleteNotification(notification));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}
