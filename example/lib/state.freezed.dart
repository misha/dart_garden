// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameData {

 int get serial; int get turn; Iterable<(Position, Piece)> get contents; Iterable<(Piece, Player)> get owners; Result? get result;
/// Create a copy of GameData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameDataCopyWith<GameData> get copyWith => _$GameDataCopyWithImpl<GameData>(this as GameData, _$identity);

  /// Serializes this GameData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameData&&(identical(other.serial, serial) || other.serial == serial)&&(identical(other.turn, turn) || other.turn == turn)&&const DeepCollectionEquality().equals(other.contents, contents)&&const DeepCollectionEquality().equals(other.owners, owners)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serial,turn,const DeepCollectionEquality().hash(contents),const DeepCollectionEquality().hash(owners),result);

@override
String toString() {
  return 'GameData(serial: $serial, turn: $turn, contents: $contents, owners: $owners, result: $result)';
}


}

/// @nodoc
abstract mixin class $GameDataCopyWith<$Res>  {
  factory $GameDataCopyWith(GameData value, $Res Function(GameData) _then) = _$GameDataCopyWithImpl;
@useResult
$Res call({
 int serial, int turn, Iterable<(Position, Piece)> contents, Iterable<(Piece, Player)> owners, Result? result
});


$ResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$GameDataCopyWithImpl<$Res>
    implements $GameDataCopyWith<$Res> {
  _$GameDataCopyWithImpl(this._self, this._then);

  final GameData _self;
  final $Res Function(GameData) _then;

/// Create a copy of GameData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serial = null,Object? turn = null,Object? contents = null,Object? owners = null,Object? result = freezed,}) {
  return _then(_self.copyWith(
serial: null == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as int,turn: null == turn ? _self.turn : turn // ignore: cast_nullable_to_non_nullable
as int,contents: null == contents ? _self.contents : contents // ignore: cast_nullable_to_non_nullable
as Iterable<(Position, Piece)>,owners: null == owners ? _self.owners : owners // ignore: cast_nullable_to_non_nullable
as Iterable<(Piece, Player)>,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,
  ));
}
/// Create a copy of GameData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameData].
extension GameDataPatterns on GameData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameData value)  $default,){
final _that = this;
switch (_that) {
case _GameData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameData value)?  $default,){
final _that = this;
switch (_that) {
case _GameData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int serial,  int turn,  Iterable<(Position, Piece)> contents,  Iterable<(Piece, Player)> owners,  Result? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameData() when $default != null:
return $default(_that.serial,_that.turn,_that.contents,_that.owners,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int serial,  int turn,  Iterable<(Position, Piece)> contents,  Iterable<(Piece, Player)> owners,  Result? result)  $default,) {final _that = this;
switch (_that) {
case _GameData():
return $default(_that.serial,_that.turn,_that.contents,_that.owners,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int serial,  int turn,  Iterable<(Position, Piece)> contents,  Iterable<(Piece, Player)> owners,  Result? result)?  $default,) {final _that = this;
switch (_that) {
case _GameData() when $default != null:
return $default(_that.serial,_that.turn,_that.contents,_that.owners,_that.result);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameData implements GameData {
  const _GameData({required this.serial, required this.turn, required this.contents, required this.owners, required this.result});
  factory _GameData.fromJson(Map<String, dynamic> json) => _$GameDataFromJson(json);

@override final  int serial;
@override final  int turn;
@override final  Iterable<(Position, Piece)> contents;
@override final  Iterable<(Piece, Player)> owners;
@override final  Result? result;

/// Create a copy of GameData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameDataCopyWith<_GameData> get copyWith => __$GameDataCopyWithImpl<_GameData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameData&&(identical(other.serial, serial) || other.serial == serial)&&(identical(other.turn, turn) || other.turn == turn)&&const DeepCollectionEquality().equals(other.contents, contents)&&const DeepCollectionEquality().equals(other.owners, owners)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serial,turn,const DeepCollectionEquality().hash(contents),const DeepCollectionEquality().hash(owners),result);

@override
String toString() {
  return 'GameData(serial: $serial, turn: $turn, contents: $contents, owners: $owners, result: $result)';
}


}

/// @nodoc
abstract mixin class _$GameDataCopyWith<$Res> implements $GameDataCopyWith<$Res> {
  factory _$GameDataCopyWith(_GameData value, $Res Function(_GameData) _then) = __$GameDataCopyWithImpl;
@override @useResult
$Res call({
 int serial, int turn, Iterable<(Position, Piece)> contents, Iterable<(Piece, Player)> owners, Result? result
});


@override $ResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$GameDataCopyWithImpl<$Res>
    implements _$GameDataCopyWith<$Res> {
  __$GameDataCopyWithImpl(this._self, this._then);

  final _GameData _self;
  final $Res Function(_GameData) _then;

/// Create a copy of GameData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serial = null,Object? turn = null,Object? contents = null,Object? owners = null,Object? result = freezed,}) {
  return _then(_GameData(
serial: null == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as int,turn: null == turn ? _self.turn : turn // ignore: cast_nullable_to_non_nullable
as int,contents: null == contents ? _self.contents : contents // ignore: cast_nullable_to_non_nullable
as Iterable<(Position, Piece)>,owners: null == owners ? _self.owners : owners // ignore: cast_nullable_to_non_nullable
as Iterable<(Piece, Player)>,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Result?,
  ));
}

/// Create a copy of GameData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
