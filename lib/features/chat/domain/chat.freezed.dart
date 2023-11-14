// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Chat.fromJson(json);
}

/// @nodoc
mixin _$Chat {
  String get chatID => throw _privateConstructorUsedError;
  String get groupID => throw _privateConstructorUsedError;
  List<String> get userIDs => throw _privateConstructorUsedError;
  List<String> get messageIDs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res, Chat>;
  @useResult
  $Res call(
      {String chatID,
      String groupID,
      List<String> userIDs,
      List<String> messageIDs});
}

/// @nodoc
class _$ChatCopyWithImpl<$Res, $Val extends Chat>
    implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatID = null,
    Object? groupID = null,
    Object? userIDs = null,
    Object? messageIDs = null,
  }) {
    return _then(_value.copyWith(
      chatID: null == chatID
          ? _value.chatID
          : chatID // ignore: cast_nullable_to_non_nullable
              as String,
      groupID: null == groupID
          ? _value.groupID
          : groupID // ignore: cast_nullable_to_non_nullable
              as String,
      userIDs: null == userIDs
          ? _value.userIDs
          : userIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      messageIDs: null == messageIDs
          ? _value.messageIDs
          : messageIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatImplCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$$ChatImplCopyWith(
          _$ChatImpl value, $Res Function(_$ChatImpl) then) =
      __$$ChatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String chatID,
      String groupID,
      List<String> userIDs,
      List<String> messageIDs});
}

/// @nodoc
class __$$ChatImplCopyWithImpl<$Res>
    extends _$ChatCopyWithImpl<$Res, _$ChatImpl>
    implements _$$ChatImplCopyWith<$Res> {
  __$$ChatImplCopyWithImpl(_$ChatImpl _value, $Res Function(_$ChatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatID = null,
    Object? groupID = null,
    Object? userIDs = null,
    Object? messageIDs = null,
  }) {
    return _then(_$ChatImpl(
      chatID: null == chatID
          ? _value.chatID
          : chatID // ignore: cast_nullable_to_non_nullable
              as String,
      groupID: null == groupID
          ? _value.groupID
          : groupID // ignore: cast_nullable_to_non_nullable
              as String,
      userIDs: null == userIDs
          ? _value._userIDs
          : userIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      messageIDs: null == messageIDs
          ? _value._messageIDs
          : messageIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatImpl implements _Chat {
  const _$ChatImpl(
      {required this.chatID,
      required this.groupID,
      required final List<String> userIDs,
      required final List<String> messageIDs})
      : _userIDs = userIDs,
        _messageIDs = messageIDs;

  factory _$ChatImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatImplFromJson(json);

  @override
  final String chatID;
  @override
  final String groupID;
  final List<String> _userIDs;
  @override
  List<String> get userIDs {
    if (_userIDs is EqualUnmodifiableListView) return _userIDs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userIDs);
  }

  final List<String> _messageIDs;
  @override
  List<String> get messageIDs {
    if (_messageIDs is EqualUnmodifiableListView) return _messageIDs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messageIDs);
  }

  @override
  String toString() {
    return 'Chat(chatID: $chatID, groupID: $groupID, userIDs: $userIDs, messageIDs: $messageIDs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatImpl &&
            (identical(other.chatID, chatID) || other.chatID == chatID) &&
            (identical(other.groupID, groupID) || other.groupID == groupID) &&
            const DeepCollectionEquality().equals(other._userIDs, _userIDs) &&
            const DeepCollectionEquality()
                .equals(other._messageIDs, _messageIDs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      chatID,
      groupID,
      const DeepCollectionEquality().hash(_userIDs),
      const DeepCollectionEquality().hash(_messageIDs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatImplCopyWith<_$ChatImpl> get copyWith =>
      __$$ChatImplCopyWithImpl<_$ChatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatImplToJson(
      this,
    );
  }
}

abstract class _Chat implements Chat {
  const factory _Chat(
      {required final String chatID,
      required final String groupID,
      required final List<String> userIDs,
      required final List<String> messageIDs}) = _$ChatImpl;

  factory _Chat.fromJson(Map<String, dynamic> json) = _$ChatImpl.fromJson;

  @override
  String get chatID;
  @override
  String get groupID;
  @override
  List<String> get userIDs;
  @override
  List<String> get messageIDs;
  @override
  @JsonKey(ignore: true)
  _$$ChatImplCopyWith<_$ChatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
