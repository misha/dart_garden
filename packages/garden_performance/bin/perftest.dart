import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';
import 'package:collection/collection.dart';
import 'package:garden/garden.dart';
import 'package:json_annotation/json_annotation.dart';

part 'perftest.g.dart';

// dart format off
const _operations = {
  'value': ['set'],
  'list': ['set', 'add', 'addAll', 'insert', 'insertAll', 'remove', 'removeAt', 'removeRange', 'removeWhere', 'removeWhereSparse', 'removeLast', 'clear'],
  'set': ['add', 'addAll', 'remove', 'removeAll', 'removeWhere', 'clear'],
  'map': ['set', 'addEntries', 'remove', 'removeWhere', 'update', 'updateAll', 'clear'],
  'rng': ['nextInt'],
};
// dart format on

@JsonSerializable()
class RunRecord {
  const RunRecord({
    required this.name,
    required this.time,
  });

  final String name;
  final double time;

  factory RunRecord.fromJson(Map<String, dynamic> json) => _$RunRecordFromJson(json);
  Map<String, dynamic> toJson() => _$RunRecordToJson(this);
}

@JsonSerializable()
class PerformanceRecord {
  static final file = File('performance.json');

  PerformanceRecord({
    required this.runs,
    required this.seed,
    required this.records,
    DateTime? timestamp,
    double? total,
  }) : timestamp = timestamp ?? DateTime.now(),
       total = total ?? records.map((record) => record.time).sum;

  final int runs;
  final int seed;
  final List<RunRecord> records;
  final DateTime timestamp;
  final double total;

  double? operator [](String key) => records.firstWhereOrNull((r) => r.name == key)?.time;

  static Future<PerformanceRecord?> load() async {
    if (!await file.exists()) return null;
    final data = await file.readAsString();
    return .fromJson(jsonDecode(data));
  }

  Future<void> save() async {
    const encoder = JsonEncoder.withIndent('  ');
    final data = encoder.convert(toJson());
    await file.writeAsString(data);
  }

  factory PerformanceRecord.fromJson(Map<String, dynamic> json) => _$PerformanceRecordFromJson(json);
  Map<String, dynamic> toJson() => _$PerformanceRecordToJson(this);
}

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption(
      'runs',
      abbr: 'n',
      defaultsTo: '100000',
      help: 'Iterations per test.',
    )
    ..addOption(
      'seed',
      abbr: 's',
      defaultsTo: '12345',
      help: 'RNG seed.',
    )
    ..addFlag(
      'save',
      defaultsTo: false,
      help: 'Write results to file.',
    )
    ..addFlag(
      'save-if-better',
      defaultsTo: false,
      help: 'Write results only if total time improved.',
    );

  final results = parser.parse(args);
  final runs = int.parse(results.option('runs')!);
  final seed = int.parse(results.option('seed')!);
  final saveIfBetter = results.flag('save-if-better');
  final save = results.flag('save') || saveIfBetter;
  final rng = Random(seed);
  final tests = <(String, String)>[];

  if (results.rest.isNotEmpty) {
    final leaf = results.rest.first;

    if (!_operations.containsKey(leaf)) {
      print('Unknown leaf type: $leaf');
      print('Available: ${_operations.keys.join(', ')}');
      return;
    }

    if (results.rest.length > 1) {
      final operations = results.rest.skip(1).toSet();

      for (final operation in operations) {
        if (!_operations[leaf]!.contains(operation)) {
          print('Unknown operation "$operation" for $leaf');
          print('Available: ${_operations[leaf]!.join(', ')}');
          return;
        }

        tests.add((leaf, operation));
      }
    } else {
      for (final operation in _operations[leaf]!) {
        tests.add((leaf, operation));
      }
    }
  } else {
    _operations.forEach((leaf, operations) {
      for (final operation in operations) {
        tests.add((leaf, operation));
      }
    });
  }

  final previous = await PerformanceRecord.load();
  final records = <RunRecord>[];

  print('$runs per test, seed $seed');
  print('===');

  for (final (leaf, operation) in tests) {
    final elapsed = _test(leaf, operation, runs, rng);
    final ms = elapsed.inMicroseconds / 1000;
    records.add(RunRecord(name: '$leaf $operation', time: ms));
  }

  final record = PerformanceRecord(
    runs: runs,
    seed: seed,
    records: records,
  );

  _report(record, previous);
  print('===');

  if (save) {
    if (saveIfBetter && previous != null && record.total >= previous.total) {
      print('Not saved (no improvement).');
    } else {
      await record.save();
      print('Saved to ${PerformanceRecord.file.path}.');
    }
  }
}

void _report(PerformanceRecord current, [PerformanceRecord? previous]) {
  for (final record in current.records) {
    final previousTime = previous?[record.name];

    print(
      [
        record.name.padRight(20),
        '${record.time.toStringAsFixed(1)} ms'.padRight(10),
        if (previousTime != null) //
          '(${_compare(record.time, previousTime)})',
      ].join('\t'),
    );
  }

  print('===');

  print(
    [
      '${'total'.padRight(20)}',
      '${current.total.round()} ms'.padRight(10),
      if (previous != null) //
        '(${_compare(current.total, previous.total)})',
    ].join('\t'),
  );
}

String _compare(num current, num? previous) {
  if (previous == null) return '';
  final delta = current - previous;
  final sign = delta >= 0 ? '+' : '';
  final pct = previous > 0 ? (delta / previous * 100) : 0.0;
  return '$sign${delta.toStringAsFixed(1)} ms / $sign${pct.toStringAsFixed(0)}%';
}

List<int> _generate(
  int count,
  Random rng, {
  int max = 1 << 32,
}) {
  return .generate(count, (_) => rng.nextInt(max));
}

void Function(int i) _build(String type, String operation, int runs, Random rng) {
  switch (type) {
    case 'value':
      final leaf = ValueLeaf(0);

      switch (operation) {
        case 'set':
          final values = _generate(runs, rng);
          return (i) => leaf.value = values[i];

        default:
          throw ArgumentError.value(operation, 'operation');
      }

    case 'list':
      final leaf = ListLeaf(.generate(100, (i) => i).shuffled(rng));

      switch (operation) {
        case 'set':
          final indices = _generate(runs, rng, max: 100);
          final values = _generate(runs, rng);
          return (i) => leaf[indices[i]] = values[i];

        case 'add':
          final values = _generate(runs, rng);
          return (i) => leaf.add(values[i]);

        case 'addAll':
          final batches = List.generate(runs, (_) => _generate(10, rng));
          return (i) => leaf.addAll(batches[i]);

        case 'insert':
          final insertIndices = _generate(runs, rng, max: 100);
          final insertValues = _generate(runs, rng);
          return (i) => leaf.insert(insertIndices[i], insertValues[i]);

        case 'insertAll':
          final insertAllIndices = _generate(runs, rng, max: 100);
          final insertAllBatches = List.generate(runs, (_) => _generate(10, rng));
          return (i) => leaf.insertAll(insertAllIndices[i], insertAllBatches[i]);

        case 'remove':
          final targets = _generate(runs, rng, max: 100);
          return (i) => leaf.remove(targets[i]);

        case 'removeAt':
          final indices = _generate(runs, rng, max: 100);
          return (i) => leaf.removeAt(indices[i]);

        case 'removeRange':
          final starts = _generate(runs, rng, max: 90);
          final lengths = _generate(runs, rng, max: 10);
          return (i) => leaf.removeRange(starts[i], starts[i] + lengths[i]);

        case 'removeWhere':
          final thresholds = _generate(runs, rng, max: 100);
          return (i) => leaf.removeWhere((element) => element < thresholds[i]);

        case 'removeWhereSparse':
          final picks = _generate(runs, rng, max: 100).shuffled(rng);
          return (i) => leaf.removeWhereSparse((element) => element == picks[i]);

        case 'removeLast':
          return (_) => leaf.removeLast();

        case 'clear':
          return (_) => leaf.clear();

        default:
          throw ArgumentError.value(operation, 'operation');
      }

    case 'set':
      final leaf = SetLeaf(.generate(100, (i) => i).shuffled(rng));

      switch (operation) {
        case 'add':
          final values = _generate(runs, rng);
          return (i) => leaf.add(values[i]);

        case 'addAll':
          final batches = List.generate(runs, (_) => _generate(10, rng));
          return (i) => leaf.addAll(batches[i]);

        case 'remove':
          final targets = _generate(runs, rng, max: 100);
          return (i) => leaf.remove(targets[i]);

        case 'removeAll':
          final batches = List.generate(runs, (_) => _generate(5, rng, max: 100));
          return (i) => leaf.removeAll(batches[i]);

        case 'removeWhere':
          final thresholds = _generate(runs, rng, max: 100);
          return (i) => leaf.removeWhere((element) => element < thresholds[i]);

        case 'clear':
          return (_) => leaf.clear();

        default:
          throw ArgumentError.value(operation, 'operation');
      }

    case 'map':
      final leaf = MapLeaf({
        for (final i in List.generate(100, (i) => i).shuffled(rng)) //
          i: i,
      });

      switch (operation) {
        case 'set':
          final keys = _generate(runs, rng, max: 100);
          final values = _generate(runs, rng);
          return (i) => leaf[keys[i]] = values[i];

        case 'addEntries':
          final batches = List.generate(runs, (_) {
            final keys = _generate(5, rng, max: 100);
            final values = _generate(5, rng);
            return [for (var j = 0; j < 5; j++) MapEntry(keys[j], values[j])];
          });
          return (i) => leaf.addEntries(batches[i]);

        case 'remove':
          final keys = _generate(runs, rng, max: 100);
          return (i) => leaf.remove(keys[i]);

        case 'removeWhere':
          final thresholds = _generate(runs, rng, max: 100);
          return (i) => leaf.removeWhere((key, _) => key < thresholds[i]);

        case 'update':
          final keys = _generate(runs, rng, max: 100);
          final values = _generate(runs, rng);
          return (i) => leaf.update(keys[i], (_) => values[i]);

        case 'updateAll':
          final values = _generate(runs, rng);
          return (i) => leaf.updateAll((_, _) => values[i]);

        case 'clear':
          return (_) => leaf.clear();

        default:
          throw ArgumentError.value(operation, 'operation');
      }

    case 'rng':
      final leaf = RngLeaf(rng.nextInt(1 << 32));

      switch (operation) {
        case 'nextInt':
          final counts = _generate(runs, rng, max: 10);
          return (i) {
            for (var j = 0; j <= counts[i]; j++) {
              leaf.nextInt();
            }
          };

        default:
          throw ArgumentError.value(operation, 'operation');
      }

    default:
      throw ArgumentError.value(type, 'type');
  }
}

Duration _test(String leaf, String operation, int runs, Random rng) {
  final garden = Garden();
  final test = garden.grow(() => _build(leaf, operation, runs, rng));
  final runtime = Stopwatch()..start();

  for (var i = 0; i < runs; i += 1) {
    garden.branch();
    test(i);
    garden.revert();
  }

  runtime.stop();
  return runtime.elapsed;
}
