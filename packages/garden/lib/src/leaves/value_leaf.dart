import 'package:garden/src/garden.dart';

/// A [Leaf] that tracks mutations to a single boxed value.
class ValueLeaf<T> with Leaf {
  ValueLeaf(T value) : _value = value;

  T _value;
  T get value => _value;

  set value(T updated) {
    final backup = value;
    record(() => _value = backup);
    _value = updated;
  }
}
