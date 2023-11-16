/// The Chat object.
/**
class Chat {
  String chatID;
  String groupID;
  List<String> userIDs;
  List<String> messageIDs;

  /// Constructor
  Chat(
      {required this.chatID,
      required this.groupID,
      required this.userIDs,
      required this.messageIDs});
}
*/

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@unfreezed
class Chat with _$Chat{
  factory Chat({
    required final String chatID,
    required final String groupID,
    required List<String> userIDs,
    required List<String> messageIDs,
}) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}