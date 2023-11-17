import 'package:freezed_annotation/freezed_annotation.dart';

import '../../message/domain/message.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@unfreezed
class Group with _$Group {
  factory Group({
    required final String groupID,
    required final String groupName,
    required final String semYear,
    required final String owner,
    required String groupImage,
    required String groupDescription,
    required List<Message> newMessages,
    required String chatID,
    required List<String> eventIDs,
    required List<String> userIDs,
    required List<String> interests,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}


