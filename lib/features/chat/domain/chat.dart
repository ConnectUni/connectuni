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

@Freezed()
class Chat with _$Chat{
  const factory Chat({
    required String chatID,
    required String groupID,
    required List<String> userIDs,
    required List<String> messageIDs,
}) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}