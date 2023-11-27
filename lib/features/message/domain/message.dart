import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';


@freezed
class Message with _$Message {
  const factory Message({
    required final String messageId,
    required final String senderId,
    final String? groupId,
    required final String messageContent,
}) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
