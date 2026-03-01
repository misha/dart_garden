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
    addEntries(other.entries);
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    final added = <K>[];
    final overwritten = <MapEntry<K, V>>[];

    for (final MapEntry(:key, :value) in newEntries) {
      if (containsKey(key)) {
        overwritten.add(.new(key, super[key] as V));
      } else {
        added.add(key);
      }

      super[key] = value;
    }

    if (added.isNotEmpty || overwritten.isNotEmpty) {
      record(() {
        super.addEntries(overwritten);
        added.forEach(super.remove);
      });
    }
  }

  @override
  V? remove(Object? key) {
    if (key is! K) return null;
    final before = length;
    final value = super.remove(key);
    final after = length;
    if (before == after) return null;
    record(() => super[key] = value as V);
    return value;
  }

  @override
  void removeWhere(bool Function(K, V) test) {
    final removed = <MapEntry<K, V>>[];

    for (final entry in entries) {
      if (test(entry.key, entry.value)) {
        removed.add(entry);
      }
    }

    if (removed.isEmpty) return;
    removed.forEach((entry) => super.remove(entry.key));
    record(() => super.addEntries(removed));
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
