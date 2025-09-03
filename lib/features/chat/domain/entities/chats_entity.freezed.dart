// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chats_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatsEntity {

 String get id; ChatType get type; List<String> get participants; String? get lastMessage; String? get lastMessageSender; bool get isBlocked; DateTime? get updatedAt; String? get lastMessageId;
/// Create a copy of ChatsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatsEntityCopyWith<ChatsEntity> get copyWith => _$ChatsEntityCopyWithImpl<ChatsEntity>(this as ChatsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageSender, lastMessageSender) || other.lastMessageSender == lastMessageSender)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(participants),lastMessage,lastMessageSender,isBlocked,updatedAt,lastMessageId);

@override
String toString() {
  return 'ChatsEntity(id: $id, type: $type, participants: $participants, lastMessage: $lastMessage, lastMessageSender: $lastMessageSender, isBlocked: $isBlocked, updatedAt: $updatedAt, lastMessageId: $lastMessageId)';
}


}

/// @nodoc
abstract mixin class $ChatsEntityCopyWith<$Res>  {
  factory $ChatsEntityCopyWith(ChatsEntity value, $Res Function(ChatsEntity) _then) = _$ChatsEntityCopyWithImpl;
@useResult
$Res call({
 String id, ChatType type, List<String> participants, String? lastMessage, String? lastMessageSender, bool isBlocked, DateTime? updatedAt, String? lastMessageId
});




}
/// @nodoc
class _$ChatsEntityCopyWithImpl<$Res>
    implements $ChatsEntityCopyWith<$Res> {
  _$ChatsEntityCopyWithImpl(this._self, this._then);

  final ChatsEntity _self;
  final $Res Function(ChatsEntity) _then;

/// Create a copy of ChatsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? participants = null,Object? lastMessage = freezed,Object? lastMessageSender = freezed,Object? isBlocked = null,Object? updatedAt = freezed,Object? lastMessageId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ChatType,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSender: freezed == lastMessageSender ? _self.lastMessageSender : lastMessageSender // ignore: cast_nullable_to_non_nullable
as String?,isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatsEntity].
extension ChatsEntityPatterns on ChatsEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatsEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatsEntity value)  $default,){
final _that = this;
switch (_that) {
case _ChatsEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ChatsEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ChatType type,  List<String> participants,  String? lastMessage,  String? lastMessageSender,  bool isBlocked,  DateTime? updatedAt,  String? lastMessageId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatsEntity() when $default != null:
return $default(_that.id,_that.type,_that.participants,_that.lastMessage,_that.lastMessageSender,_that.isBlocked,_that.updatedAt,_that.lastMessageId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ChatType type,  List<String> participants,  String? lastMessage,  String? lastMessageSender,  bool isBlocked,  DateTime? updatedAt,  String? lastMessageId)  $default,) {final _that = this;
switch (_that) {
case _ChatsEntity():
return $default(_that.id,_that.type,_that.participants,_that.lastMessage,_that.lastMessageSender,_that.isBlocked,_that.updatedAt,_that.lastMessageId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ChatType type,  List<String> participants,  String? lastMessage,  String? lastMessageSender,  bool isBlocked,  DateTime? updatedAt,  String? lastMessageId)?  $default,) {final _that = this;
switch (_that) {
case _ChatsEntity() when $default != null:
return $default(_that.id,_that.type,_that.participants,_that.lastMessage,_that.lastMessageSender,_that.isBlocked,_that.updatedAt,_that.lastMessageId);case _:
  return null;

}
}

}

/// @nodoc


class _ChatsEntity implements ChatsEntity {
  const _ChatsEntity({this.id = '', this.type = ChatType.private, final  List<String> participants = const [], this.lastMessage = '', this.lastMessageSender = '', this.isBlocked = false, this.updatedAt, this.lastMessageId = ''}): _participants = participants;
  

@override@JsonKey() final  String id;
@override@JsonKey() final  ChatType type;
 final  List<String> _participants;
@override@JsonKey() List<String> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override@JsonKey() final  String? lastMessage;
@override@JsonKey() final  String? lastMessageSender;
@override@JsonKey() final  bool isBlocked;
@override final  DateTime? updatedAt;
@override@JsonKey() final  String? lastMessageId;

/// Create a copy of ChatsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatsEntityCopyWith<_ChatsEntity> get copyWith => __$ChatsEntityCopyWithImpl<_ChatsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageSender, lastMessageSender) || other.lastMessageSender == lastMessageSender)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(_participants),lastMessage,lastMessageSender,isBlocked,updatedAt,lastMessageId);

@override
String toString() {
  return 'ChatsEntity(id: $id, type: $type, participants: $participants, lastMessage: $lastMessage, lastMessageSender: $lastMessageSender, isBlocked: $isBlocked, updatedAt: $updatedAt, lastMessageId: $lastMessageId)';
}


}

/// @nodoc
abstract mixin class _$ChatsEntityCopyWith<$Res> implements $ChatsEntityCopyWith<$Res> {
  factory _$ChatsEntityCopyWith(_ChatsEntity value, $Res Function(_ChatsEntity) _then) = __$ChatsEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, ChatType type, List<String> participants, String? lastMessage, String? lastMessageSender, bool isBlocked, DateTime? updatedAt, String? lastMessageId
});




}
/// @nodoc
class __$ChatsEntityCopyWithImpl<$Res>
    implements _$ChatsEntityCopyWith<$Res> {
  __$ChatsEntityCopyWithImpl(this._self, this._then);

  final _ChatsEntity _self;
  final $Res Function(_ChatsEntity) _then;

/// Create a copy of ChatsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? participants = null,Object? lastMessage = freezed,Object? lastMessageSender = freezed,Object? isBlocked = null,Object? updatedAt = freezed,Object? lastMessageId = freezed,}) {
  return _then(_ChatsEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ChatType,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSender: freezed == lastMessageSender ? _self.lastMessageSender : lastMessageSender // ignore: cast_nullable_to_non_nullable
as String?,isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
