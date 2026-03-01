// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perftest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunRecord _$RunRecordFromJson(Map<String, dynamic> json) => RunRecord(
  name: json['name'] as String,
  time: (json['time'] as num).toDouble(),
);

Map<String, dynamic> _$RunRecordToJson(RunRecord instance) => <String, dynamic>{
  'name': instance.name,
  'time': instance.time,
};

PerformanceRecord _$PerformanceRecordFromJson(Map<String, dynamic> json) =>
    PerformanceRecord(
      runs: (json['runs'] as num).toInt(),
      seed: (json['seed'] as num).toInt(),
      records: (json['records'] as List<dynamic>)
          .map((e) => RunRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PerformanceRecordToJson(PerformanceRecord instance) =>
    <String, dynamic>{
      'runs': instance.runs,
      'seed': instance.seed,
      'records': instance.records,
      'timestamp': instance.timestamp.toIso8601String(),
      'total': instance.total,
    };
