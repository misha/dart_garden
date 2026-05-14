// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Entity _$EntityFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'player':
          return Player.fromJson(
            json
          );
                case 'piece':
          return Piece.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Entity',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Entity {



  /// Serializes this Entity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Entity);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Entity()';
}


}

/// @nodoc
class $EntityCopyWith<$Res>  {
$EntityCopyWith(Entity _, $Res Function(Entity) __);
}


/// Adds pattern-matching-related methods to [Entity].
extension EntityPatterns on Entity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Player value)?  player,TResult Function( Piece value)?  piece,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Player() when player != null:
return player(_that);case Piece() when piece != null:
return piece(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Player value)  player,required TResult Function( Piece value)  piece,}){
final _that = this;
switch (_that) {
case Player():
return player(_that);case Piece():
return piece(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Player value)?  player,TResult? Function( Piece value)?  piece,}){
final _that = this;
switch (_that) {
case Player() when player != null:
return player(_that);case Piece() when piece != null:
return piece(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Token token)?  player,TResult Function( int id)?  piece,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Player() when player != null:
return player(_that.token);case Piece() when piece != null:
return piece(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Token token)  player,required TResult Function( int id)  piece,}) {final _that = this;
switch (_that) {
case Player():
return player(_that.token);case Piece():
return piece(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Token token)?  player,TResult? Function( int id)?  piece,}) {final _that = this;
switch (_that) {
case Player() when player != null:
return player(_that.token);case Piece() when piece != null:
return piece(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class Player extends Entity {
  const Player(this.token, {final  String? $type}): $type = $type ?? 'player',super._();
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

 final  Token token;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerCopyWith<Player> get copyWith => _$PlayerCopyWithImpl<Player>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Player&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'Entity.player(token: $token)';
}


}

/// @nodoc
abstract mixin class $PlayerCopyWith<$Res> implements $EntityCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) _then) = _$PlayerCopyWithImpl;
@useResult
$Res call({
 Token token
});




}
/// @nodoc
class _$PlayerCopyWithImpl<$Res>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._self, this._then);

  final Player _self;
  final $Res Function(Player) _then;

/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(Player(
null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as Token,
  ));
}


}

/// @nodoc
@JsonSerializable()

class Piece extends Entity {
  const Piece(this.id, {final  String? $type}): $type = $type ?? 'piece',super._();
  factory Piece.fromJson(Map<String, dynamic> json) => _$PieceFromJson(json);

 final  int id;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PieceCopyWith<Piece> get copyWith => _$PieceCopyWithImpl<Piece>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PieceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Piece&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'Entity.piece(id: $id)';
}


}

/// @nodoc
abstract mixin class $PieceCopyWith<$Res> implements $EntityCopyWith<$Res> {
  factory $PieceCopyWith(Piece value, $Res Function(Piece) _then) = _$PieceCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$PieceCopyWithImpl<$Res>
    implements $PieceCopyWith<$Res> {
  _$PieceCopyWithImpl(this._self, this._then);

  final Piece _self;
  final $Res Function(Piece) _then;

/// Create a copy of Entity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(Piece(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
