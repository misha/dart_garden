// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WinResult _$WinResultFromJson(Map<String, dynamic> json) => WinResult(
  Player.fromJson(json['winner'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WinResultToJson(WinResult instance) => <String, dynamic>{
  'winner': instance.winner.toJson(),
  'runtimeType': instance.$type,
};

DrawResult _$DrawResultFromJson(Map<String, dynamic> json) =>
    DrawResult($type: json['runtimeType'] as String?);

Map<String, dynamic> _$DrawResultToJson(DrawResult instance) =>
    <String, dynamic>{'runtimeType': instance.$type};
