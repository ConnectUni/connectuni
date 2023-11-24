// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      notificationID: json['notificationID'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      receiverID: json['receiverID'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      senderID: json['senderID'] as String?,
      eventID: json['eventID'] as String?,
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'notificationID': instance.notificationID,
      'timestamp': instance.timestamp.toIso8601String(),
      'receiverID': instance.receiverID,
      'title': instance.title,
      'type': instance.type,
      'senderID': instance.senderID,
      'eventID': instance.eventID,
    };
