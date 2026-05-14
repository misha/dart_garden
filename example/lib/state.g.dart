// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameData _$GameDataFromJson(Map<String, dynamic> json) => _GameData(
  serial: (json['serial'] as num).toInt(),
  turn: (json['turn'] as num).toInt(),
  contents: (json['contents'] as List<dynamic>).map(
    (e) => _$recordConvert(
      e,
      ($jsonValue) => (
        Position.fromJson($jsonValue[r'$1'] as Map<String, dynamic>),
        Piece.fromJson($jsonValue[r'$2'] as Map<String, dynamic>),
      ),
    ),
  ),
  owners: (json['owners'] as List<dynamic>).map(
    (e) => _$recordConvert(
      e,
      ($jsonValue) => (
        Piece.fromJson($jsonValue[r'$1'] as Map<String, dynamic>),
        Player.fromJson($jsonValue[r'$2'] as Map<String, dynamic>),
      ),
    ),
  ),
  result: json['result'] == null
      ? null
      : Result.fromJson(json['result'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GameDataToJson(_GameData instance) => <String, dynamic>{
  'serial': instance.serial,
  'turn': instance.turn,
  'contents': instance.contents
      .map((e) => <String, dynamic>{r'$1': e.$1, r'$2': e.$2})
      .toList(),
  'owners': instance.owners
      .map((e) => <String, dynamic>{r'$1': e.$1, r'$2': e.$2})
      .toList(),
  'result': instance.result,
};

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);
