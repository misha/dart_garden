import 'dart:typed_data';

import 'package:binary/binary.dart';
import 'package:chaos/chaos.dart';
import 'package:garden/src/garden.dart';

/// A leaf with resumable RNG state, powered by [chaos](https://pub.dev/packages/chaos).
class RngLeaf with Leaf implements Random {
  RngLeaf([int? seed]) : _source = Xoshiro128P(seed);
  RngLeaf.restore(Uint8List state) : _source = Xoshiro128P.fromSeed(state);

  final Xoshiro128 _source;

  @override
  bool nextBool() {
    _save();
    return _source.nextBool();
  }

  @override
  double nextDouble() {
    _save();
    return _source.nextDouble();
  }

  @override
  int nextInt([int max = Uint32.max]) {
    _save();
    return _source.nextInt(max);
  }

  Uint8List save() => _source.save();

  void _save() {
    if (!garden.isBranched) return;
    final state = _source.save();
    record(() => _source.restore(state));
  }
}
