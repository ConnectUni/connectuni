/// USER OBJECT

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@unfreezed
class User with _$User {

  factory User({
    required final String uid,
    required final String email,
    required String displayName,
    @Default('') String pfp,
    required String major,
    required String projectedGraduation,
    @Default('') String status,
    @Default([]) List<String> notificationIDs,
    @Default([]) List<String> friends,
    @Default([]) List<String> sentFriendRequests,
    @Default([]) List<String> receivedFriendRequests,
    @Default([]) List<String> groupIDs,
    @Default([]) List<String> eventIDs,
    @Default([]) List<String> interests,
}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
