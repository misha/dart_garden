// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Result _$ResultFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'win':
          return WinResult.fromJson(
            json
          );
                case 'draw':
          return DrawResult.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Result',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Result {



  /// Serializes this Result to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Result);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Result()';
}


}

/// @nodoc
class $ResultCopyWith<$Res>  {
$ResultCopyWith(Result _, $Res Function(Result) __);
}


/// Adds pattern-matching-related methods to [Result].
extension ResultPatterns on Result {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WinResult value)?  win,TResult Function( DrawResult value)?  draw,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WinResult() when win != null:
return win(_that);case DrawResult() when draw != null:
return draw(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WinResult value)  win,required TResult Function( DrawResult value)  draw,}){
final _that = this;
switch (_that) {
case WinResult():
return win(_that);case DrawResult():
return draw(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WinResult value)?  win,TResult? Function( DrawResult value)?  draw,}){
final _that = this;
switch (_that) {
case WinResult() when win != null:
return win(_that);case DrawResult() when draw != null:
return draw(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Player winner)?  win,TResult Function()?  draw,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WinResult() when win != null:
return win(_that.winner);case DrawResult() when draw != null:
return draw();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Player winner)  win,required TResult Function()  draw,}) {final _that = this;
switch (_that) {
case WinResult():
return win(_that.winner);case DrawResult():
return draw();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Player winner)?  win,TResult? Function()?  draw,}) {final _that = this;
switch (_that) {
case WinResult() when win != null:
return win(_that.winner);case DrawResult() when draw != null:
return draw();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class WinResult implements Result {
  const WinResult(this.winner, {final  String? $type}): $type = $type ?? 'win';
  factory WinResult.fromJson(Map<String, dynamic> json) => _$WinResultFromJson(json);

 final  Player winner;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WinResultCopyWith<WinResult> get copyWith => _$WinResultCopyWithImpl<WinResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WinResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WinResult&&const DeepCollectionEquality().equals(other.winner, winner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(winner));

@override
String toString() {
  return 'Result.win(winner: $winner)';
}


}

/// @nodoc
abstract mixin class $WinResultCopyWith<$Res> implements $ResultCopyWith<$Res> {
  factory $WinResultCopyWith(WinResult value, $Res Function(WinResult) _then) = _$WinResultCopyWithImpl;
@useResult
$Res call({
 Player winner
});




}
/// @nodoc
class _$WinResultCopyWithImpl<$Res>
    implements $WinResultCopyWith<$Res> {
  _$WinResultCopyWithImpl(this._self, this._then);

  final WinResult _self;
  final $Res Function(WinResult) _then;

/// Create a copy of Result
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? winner = freezed,}) {
  return _then(WinResult(
freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as Player,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DrawResult implements Result {
  const DrawResult({final  String? $type}): $type = $type ?? 'draw';
  factory DrawResult.fromJson(Map<String, dynamic> json) => _$DrawResultFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DrawResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DrawResult);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Result.draw()';
}


}




// dart format on
