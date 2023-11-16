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
    required String pfp,
    required String major,
    required String projectedGraduation,
    required String status,
    required List<User> friends,
    required List<String> groupIDs,
    required List<String> eventIDs,
    required List<String> interests,
    required String password,
}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}