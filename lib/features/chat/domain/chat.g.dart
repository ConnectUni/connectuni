// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatImpl _$$ChatImplFromJson(Map<String, dynamic> json) => _$ChatImpl(
      chatID: json['chatID'] as String,
      groupID: json['groupID'] as String,
      userIDs:
          (json['userIDs'] as List<dynamic>).map((e) => e as String).toList(),
      messageIDs: (json['messageIDs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ChatImplToJson(_$ChatImpl instance) =>
    <String, dynamic>{
      'chatID': instance.chatID,
      'groupID': instance.groupID,
      'userIDs': instance.userIDs,
      'messageIDs': instance.messageIDs,
    };
