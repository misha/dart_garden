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
    if (containsKey(key)) {
      final backup = super[key] as V;
      final value = super[key] = update(backup);
      record(() => super[key] = backup);
      return value;
    } else if (ifAbsent != null) {
      final value = ifAbsent();
      super[key] = value;
      record(() => super.remove(key));
      return value;
    } else {
      throw ArgumentError.value(key, 'key', 'Key not in map.');
    }
  }

  @override
  void updateAll(V Function(K, V) update) {
    if (isEmpty) return;
    final backup = entries.toList();
    super.updateAll(update);
    record(() => super.addEntries(backup));
  }

  @override
  void clear() {
    if (isEmpty) return;
    final backup = Map.of(this);
    record(() => super.addAll(backup));
    super.clear();
  }
}
