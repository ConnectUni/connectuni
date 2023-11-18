/// The Chat object.
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