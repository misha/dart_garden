// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
  $enumDecode(_$TokenEnumMap, json['token']),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
  'token': _$TokenEnumMap[instance.token]!,
  'runtimeType': instance.$type,
};

const _$TokenEnumMap = {Token.x: 'x', Token.o: 'o'};

Piece _$PieceFromJson(Map<String, dynamic> json) =>
    Piece((json['id'] as num).toInt(), $type: json['runtimeType'] as String?);

Map<String, dynamic> _$PieceToJson(Piece instance) => <String, dynamic>{
  'id': instance.id,
  'runtimeType': instance.$type,
};
