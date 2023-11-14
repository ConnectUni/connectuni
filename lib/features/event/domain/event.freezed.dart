// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SingleEvent _$SingleEventFromJson(Map<String, dynamic> json) {
  return _SingleEvent.fromJson(json);
}

/// @nodoc
mixin _$SingleEvent {
  String get eventID => throw _privateConstructorUsedError;
  String get eventName => throw _privateConstructorUsedError;
  String get eventLocation => throw _privateConstructorUsedError;
  DateTime get eventDate => throw _privateConstructorUsedError;
  String get groupID => throw _privateConstructorUsedError;
  String get eventIcon => throw _privateConstructorUsedError;
  String get eventDescription => throw _privateConstructorUsedError;
  List<String> get userIDs => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SingleEventCopyWith<SingleEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SingleEventCopyWith<$Res> {
  factory $SingleEventCopyWith(
          SingleEvent value, $Res Function(SingleEvent) then) =
      _$SingleEventCopyWithImpl<$Res, SingleEvent>;
  @useResult
  $Res call(
      {String eventID,
      String eventName,
      String eventLocation,
      DateTime eventDate,
      String groupID,
      String eventIcon,
      String eventDescription,
      List<String> userIDs,
      List<String> interests});
}

/// @nodoc
class _$SingleEventCopyWithImpl<$Res, $Val extends SingleEvent>
    implements $SingleEventCopyWith<$Res> {
  _$SingleEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventID = null,
    Object? eventName = null,
    Object? eventLocation = null,
    Object? eventDate = null,
    Object? groupID = null,
    Object? eventIcon = null,
    Object? eventDescription = null,
    Object? userIDs = null,
    Object? interests = null,
  }) {
    return _then(_value.copyWith(
      eventID: null == eventID
          ? _value.eventID
          : eventID // ignore: cast_nullable_to_non_nullable
              as String,
      eventName: null == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String,
      eventLocation: null == eventLocation
          ? _value.eventLocation
          : eventLocation // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      groupID: null == groupID
          ? _value.groupID
          : groupID // ignore: cast_nullable_to_non_nullable
              as String,
      eventIcon: null == eventIcon
          ? _value.eventIcon
          : eventIcon // ignore: cast_nullable_to_non_nullable
              as String,
      eventDescription: null == eventDescription
          ? _value.eventDescription
          : eventDescription // ignore: cast_nullable_to_non_nullable
              as String,
      userIDs: null == userIDs
          ? _value.userIDs
          : userIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      interests: null == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SingleEventImplCopyWith<$Res>
    implements $SingleEventCopyWith<$Res> {
  factory _$$SingleEventImplCopyWith(
          _$SingleEventImpl value, $Res Function(_$SingleEventImpl) then) =
      __$$SingleEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String eventID,
      String eventName,
      String eventLocation,
      DateTime eventDate,
      String groupID,
      String eventIcon,
      String eventDescription,
      List<String> userIDs,
      List<String> interests});
}

/// @nodoc
class __$$SingleEventImplCopyWithImpl<$Res>
    extends _$SingleEventCopyWithImpl<$Res, _$SingleEventImpl>
    implements _$$SingleEventImplCopyWith<$Res> {
  __$$SingleEventImplCopyWithImpl(
      _$SingleEventImpl _value, $Res Function(_$SingleEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventID = null,
    Object? eventName = null,
    Object? eventLocation = null,
    Object? eventDate = null,
    Object? groupID = null,
    Object? eventIcon = null,
    Object? eventDescription = null,
    Object? userIDs = null,
    Object? interests = null,
  }) {
    return _then(_$SingleEventImpl(
      eventID: null == eventID
          ? _value.eventID
          : eventID // ignore: cast_nullable_to_non_nullable
              as String,
      eventName: null == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String,
      eventLocation: null == eventLocation
          ? _value.eventLocation
          : eventLocation // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      groupID: null == groupID
          ? _value.groupID
          : groupID // ignore: cast_nullable_to_non_nullable
              as String,
      eventIcon: null == eventIcon
          ? _value.eventIcon
          : eventIcon // ignore: cast_nullable_to_non_nullable
              as String,
      eventDescription: null == eventDescription
          ? _value.eventDescription
          : eventDescription // ignore: cast_nullable_to_non_nullable
              as String,
      userIDs: null == userIDs
          ? _value._userIDs
          : userIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      interests: null == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SingleEventImpl extends _SingleEvent {
  const _$SingleEventImpl(
      {required this.eventID,
      required this.eventName,
      required this.eventLocation,
      required this.eventDate,
      required this.groupID,
      required this.eventIcon,
      required this.eventDescription,
      required final List<String> userIDs,
      required final List<String> interests})
      : _userIDs = userIDs,
        _interests = interests,
        super._();

  factory _$SingleEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$SingleEventImplFromJson(json);

  @override
  final String eventID;
  @override
  final String eventName;
  @override
  final String eventLocation;
  @override
  final DateTime eventDate;
  @override
  final String groupID;
  @override
  final String eventIcon;
  @override
  final String eventDescription;
  final List<String> _userIDs;
  @override
  List<String> get userIDs {
    if (_userIDs is EqualUnmodifiableListView) return _userIDs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userIDs);
  }

  final List<String> _interests;
  @override
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  @override
  String toString() {
    return 'SingleEvent(eventID: $eventID, eventName: $eventName, eventLocation: $eventLocation, eventDate: $eventDate, groupID: $groupID, eventIcon: $eventIcon, eventDescription: $eventDescription, userIDs: $userIDs, interests: $interests)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SingleEventImpl &&
            (identical(other.eventID, eventID) || other.eventID == eventID) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.eventLocation, eventLocation) ||
                other.eventLocation == eventLocation) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.groupID, groupID) || other.groupID == groupID) &&
            (identical(other.eventIcon, eventIcon) ||
                other.eventIcon == eventIcon) &&
            (identical(other.eventDescription, eventDescription) ||
                other.eventDescription == eventDescription) &&
            const DeepCollectionEquality().equals(other._userIDs, _userIDs) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      eventID,
      eventName,
      eventLocation,
      eventDate,
      groupID,
      eventIcon,
      eventDescription,
      const DeepCollectionEquality().hash(_userIDs),
      const DeepCollectionEquality().hash(_interests));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SingleEventImplCopyWith<_$SingleEventImpl> get copyWith =>
      __$$SingleEventImplCopyWithImpl<_$SingleEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SingleEventImplToJson(
      this,
    );
  }
}

abstract class _SingleEvent extends SingleEvent {
  const factory _SingleEvent(
      {required final String eventID,
      required final String eventName,
      required final String eventLocation,
      required final DateTime eventDate,
      required final String groupID,
      required final String eventIcon,
      required final String eventDescription,
      required final List<String> userIDs,
      required final List<String> interests}) = _$SingleEventImpl;
  const _SingleEvent._() : super._();

  factory _SingleEvent.fromJson(Map<String, dynamic> json) =
      _$SingleEventImpl.fromJson;

  @override
  String get eventID;
  @override
  String get eventName;
  @override
  String get eventLocation;
  @override
  DateTime get eventDate;
  @override
  String get groupID;
  @override
  String get eventIcon;
  @override
  String get eventDescription;
  @override
  List<String> get userIDs;
  @override
  List<String> get interests;
  @override
  @JsonKey(ignore: true)
  _$$SingleEventImplCopyWith<_$SingleEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
