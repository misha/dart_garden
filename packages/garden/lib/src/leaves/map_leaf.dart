import 'package:collection/collection.dart';
import 'package:garden/src/garden.dart';

/// A [Leaf] map implementation with branch-aware undo recording.
class MapLeaf<K, V> extends DelegatingMap<K, V> with Leaf {
  MapLeaf([Map<K, V>? data]) : super(data ?? <K, V>{});

  @override
  void operator []=(K key, V value) {
    if (containsKey(key)) {
      final backup = super[key] as V;
      record(() => super[key] = backup);
    } else {
      record(() => super.remove(key));
    }

    super[key] = value;
  }

  @override
  void addAll(Map<K, V> other) {
    throw UnimplementedError();
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> entries) {
    throw UnimplementedError();
  }

  @override
  V? remove(Object? key) {
    if (key is! K) return null;
    final value = super.remove(key);

    if (value != null) {
      record(() => super[key] = value);
    }

    return value;
  }

  @override
  void removeWhere(bool Function(K, V) test) {
    throw UnimplementedError();
  }

  @override
  V update(K key, V Function(V) update, {V Function()? ifAbsent}) {
    final hadValue = containsKey(key);
    final previousValue = this[key];
    final newValue = super.update(key, update, ifAbsent: ifAbsent);

    if (hadValue) {
      record(() => super[key] = previousValue as V);
    } else {
      record(() => super.remove(key));
    }

    return newValue;
  }

  @override
  void updateAll(V Function(K, V) update) {
    for (final entry in entries.toList()) {
      this[entry.key] = update(entry.key, entry.value);
    }
  }

  @override
  void clear() {
    if (isEmpty) return;
    final backup = Map<K, V>.unmodifiable(this);
    record(() => super.addAll(backup));
    super.clear();
  }
}
