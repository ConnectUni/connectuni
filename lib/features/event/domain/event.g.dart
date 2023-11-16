// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SingleEventImpl _$$SingleEventImplFromJson(Map<String, dynamic> json) =>
    _$SingleEventImpl(
      eventID: json['eventID'] as String,
      eventName: json['eventName'] as String,
      eventLocation: json['eventLocation'] as String,
      eventDate: DateTime.parse(json['eventDate'] as String),
      groupID: json['groupID'] as String,
      eventIcon: json['eventIcon'] as String,
      eventDescription: json['eventDescription'] as String,
      userIDs:
          (json['userIDs'] as List<dynamic>).map((e) => e as String).toList(),
      interests:
          (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$SingleEventImplToJson(_$SingleEventImpl instance) =>
    <String, dynamic>{
      'eventID': instance.eventID,
      'eventName': instance.eventName,
      'eventLocation': instance.eventLocation,
      'eventDate': instance.eventDate.toIso8601String(),
      'groupID': instance.groupID,
      'eventIcon': instance.eventIcon,
      'eventDescription': instance.eventDescription,
      'userIDs': instance.userIDs,
      'interests': instance.interests,
    };
