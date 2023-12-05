// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      groupID: json['groupID'] as String,
      groupName: json['groupName'] as String,
      semYear: json['semYear'] as String,
      professor: json['professor'] as String,
      owner: json['owner'] as String,
      groupImage: json['groupImage'] as String,
      groupDescription: json['groupDescription'] as String,
      newMessages: (json['newMessages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      chatID: json['chatID'] as String,
      eventIDs:
          (json['eventIDs'] as List<dynamic>).map((e) => e as String).toList(),
      userIDs:
          (json['userIDs'] as List<dynamic>).map((e) => e as String).toList(),
      interests:
          (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'groupID': instance.groupID,
      'groupName': instance.groupName,
      'semYear': instance.semYear,
      'professor': instance.professor,
      'owner': instance.owner,
      'groupImage': instance.groupImage,
      'groupDescription': instance.groupDescription,
      'newMessages': instance.newMessages,
      'chatID': instance.chatID,
      'eventIDs': instance.eventIDs,
      'userIDs': instance.userIDs,
      'interests': instance.interests,
    };
