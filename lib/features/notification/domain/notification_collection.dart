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

  List<String> getAllNotificationIDs() {
    return _notifications.map((notification) => notification.notificationID).toList();
  }

  int size() {
    return _notifications.length;
  }

  String getNewID() {
    String result = '';
    int newIDNum = size();

    do {
      if (newIDNum < 9) {
        result = 'notification-00${newIDNum + 1}';
      } else if (newIDNum < 99) {
        result = 'notification-0${newIDNum + 1}';
      } else {
        result = 'notification-${newIDNum + 1}';
      }

      newIDNum++;
    } while (getAllNotificationIDs().contains(result));

    return result;
  }
}
