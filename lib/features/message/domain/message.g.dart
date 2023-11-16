// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      messageId: json['messageId'] as String,
      senderId: json['senderId'] as String,
      groupId: json['groupId'] as String,
      messageContent: json['messageContent'] as String,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'groupId': instance.groupId,
      'messageContent': instance.messageContent,
    };
