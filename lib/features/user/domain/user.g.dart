// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      pfp: json['pfp'] as String? ?? '',
      major: json['major'] as String,
      projectedGraduation: json['projectedGraduation'] as String,
      status: json['status'] as String? ?? '',
      notificationIDs: (json['notificationIDs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sentFriendRequests: (json['sentFriendRequests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      receivedFriendRequests: (json['receivedFriendRequests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      groupIDs: (json['groupIDs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      eventIDs: (json['eventIDs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'pfp': instance.pfp,
      'major': instance.major,
      'projectedGraduation': instance.projectedGraduation,
      'status': instance.status,
      'notificationIDs': instance.notificationIDs,
      'friends': instance.friends,
      'sentFriendRequests': instance.sentFriendRequests,
      'receivedFriendRequests': instance.receivedFriendRequests,
      'groupIDs': instance.groupIDs,
      'eventIDs': instance.eventIDs,
      'interests': instance.interests,
    };
