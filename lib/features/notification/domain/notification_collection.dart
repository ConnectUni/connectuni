import '../../user/domain/user.dart';
import 'notification.dart';

/// Encapsulates operations on the list of [Notification] returned from Firestore.
class NotificationCollection {
  NotificationCollection(notifications) : _notifications = notifications;

  final List<Notification> _notifications;

  Notification getNotification(String notificationID) {
    return _notifications.firstWhere((notification) => notification.notificationID == notificationID);
  }

  Notification getNotificationToFrom(String receiverID, String senderID) {
    return _notifications.firstWhere((notification) => notification.receiverID == receiverID && notification.senderID == senderID);
  }

  List<Notification> getNotifications(User user) {
    return _notifications.where((notification) => notification.receiverID == user.uid).toList();
  }

  int size() {
    return _notifications.length;
  }

  String getNewID() {
    String result = '';
    switch (size()) {
      case < 10:
        result = 'notification-00${size() + 1}';
        break;
      case < 100:
        result = 'notification-0${size() + 1}';
        break;
      default:
        result = 'notification-${size() + 1}';
    }
    return result;
  }
}
