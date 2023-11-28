import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/notification.dart';
import 'notification_database.dart';

part 'notification_providers.g.dart';

@riverpod
NotificationDatabase notificationDatabase(NotificationDatabaseRef ref) {
  return NotificationDatabase(ref);
}

@riverpod
Stream<List<Notification>> notifications(NotificationsRef ref) {
  final database = ref.watch(notificationDatabaseProvider);
  return database.watchNotifications();
}
