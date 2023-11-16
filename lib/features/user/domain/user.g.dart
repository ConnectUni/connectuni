// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      pfp: json['pfp'] as String,
      major: json['major'] as String,
      projectedGraduation: json['projectedGraduation'] as String,
      status: json['status'] as String,
      friends: (json['friends'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupIDs:
          (json['groupIDs'] as List<dynamic>).map((e) => e as String).toList(),
      eventIDs:
          (json['eventIDs'] as List<dynamic>).map((e) => e as String).toList(),
      interests:
          (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
      password: json['password'] as String,
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
      'friends': instance.friends,
      'groupIDs': instance.groupIDs,
      'eventIDs': instance.eventIDs,
      'interests': instance.interests,
      'password': instance.password,
    };
