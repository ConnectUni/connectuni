/// NOTIFICATION OBJECT
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@unfreezed
class Notification with _$Notification {

  factory Notification({
    required final String notificationID,
    required final DateTime timestamp,
    required final String receiverID,
    required String title,
    required String type,
    final String? senderID,
    final String? eventID,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
}
