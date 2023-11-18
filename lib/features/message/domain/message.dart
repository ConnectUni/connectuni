import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@Freezed()
class Message with _$Message {
  const factory Message({
    required String messageId,
    required String senderId,
    required String groupId,
    required String messageContent,
}) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}