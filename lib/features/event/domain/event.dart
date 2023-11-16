import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@unfreezed
class SingleEvent with _$SingleEvent {
  factory SingleEvent({
    required final String eventID,
    required final String eventName,
    required final String eventLocation,
    required final DateTime eventDate,
    required final String groupID,
    required String eventIcon,
    required String eventDescription,
    required List<String> userIDs,
    required List<String> interests,
}) = _SingleEvent;

  factory SingleEvent.fromJson(Map<String, Object?> json) => _$SingleEventFromJson(json);
}