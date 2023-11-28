import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import '../domain/notification.dart';

// Provides access to the Firestore database storing Notification documents.
class NotificationDatabase {
  NotificationDatabase(this.ref);

  final ProviderRef<NotificationDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Notification>> watchNotifications() => _service.watchCollection(
      path: FirestorePath.notifications(),
      builder: (data, documentId) => Notification.fromJson(data!));

  Stream<Notification> watchNotification(String notificationId) => _service.watchDocument(
      path: FirestorePath.notification(notificationId),
      builder: (data, documentId) => Notification.fromJson(data!));

  Future<List<Notification>> fetchNotifications() => _service.fetchCollection(
      path: FirestorePath.notifications(),
      builder: (data, documentId) => Notification.fromJson(data!));

  Future<Notification> fetchNotification(String notificationId) => _service.fetchDocument(
      path: FirestorePath.notification(notificationId),
      builder: (data, documentId) => Notification.fromJson(data!));

  Future<void> setNotification(Notification notification) =>
      _service.setData(path: FirestorePath.notification(notification.notificationID), data: notification.toJson());

  Future<void> deleteNotification(Notification notification) =>
      _service.deleteData(path: FirestorePath.notification(notification.notificationID));
}
