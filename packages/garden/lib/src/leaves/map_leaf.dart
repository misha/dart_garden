import 'dart:collection';

import 'package:garden/src/garden.dart';

/// A [Leaf] map implementation with branch-aware undo recording.
class MapLeaf<K, V> with MapMixin<K, V>, Leaf {
  MapLeaf([Map<K, V>? data]) : _delegate = data != null ? .of(data) : {};

  Map<K, V> _delegate;

  @override
  V? operator [](Object? key) => _delegate[key];

  @override
  void operator []=(K key, V value) {
    if (_delegate.containsKey(key)) {
      final backup = _delegate[key] as V;
      record(() => _delegate[key] = backup);
    } else {
      record(() => _delegate.remove(key));
    }

    _delegate[key] = value;
  }

  @override
  Iterable<K> get keys => _delegate.keys;

  @override
  int get length => _delegate.length;

  @override
  bool containsKey(Object? key) => _delegate.containsKey(key);

  @override
  void addAll(Map<K, V> other) => addEntries(other.entries);

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    final added = <K>[];
    final overwritten = <MapEntry<K, V>>[];

    for (final MapEntry(:key, :value) in newEntries) {
      if (_delegate.containsKey(key)) {
        overwritten.add(.new(key, _delegate[key] as V));
      } else {
        added.add(key);
      }

      _delegate[key] = value;
    }

    if (added.isNotEmpty || overwritten.isNotEmpty) {
      record(() {
        _delegate.addEntries(overwritten);
        added.forEach(_delegate.remove);
      });
    }
  }

  @override
  V? remove(Object? key) {
    if (key is! K) return null;
    final before = _delegate.length;
    final value = _delegate.remove(key);
    final after = _delegate.length;
    if (before == after) return null;
    record(() => _delegate[key] = value as V);
    return value;
  }

  @override
  void removeWhere(bool Function(K, V) test) {
    final removed = <MapEntry<K, V>>[];

    for (final entry in _delegate.entries) {
      if (test(entry.key, entry.value)) {
        removed.add(entry);
      }
    }

    if (removed.isEmpty) return;
    removed.forEach((entry) => _delegate.remove(entry.key));
    record(() => _delegate.addEntries(removed));
  }

  @override
  V update(K key, V Function(V) update, {V Function()? ifAbsent}) {
    if (_delegate.containsKey(key)) {
      final backup = _delegate[key] as V;
      final value = _delegate[key] = update(backup);
      record(() => _delegate[key] = backup);
      return value;
    } else if (ifAbsent != null) {
      final value = ifAbsent();
      _delegate[key] = value;
      record(() => _delegate.remove(key));
      return value;
    } else {
      throw ArgumentError.value(key, 'key', 'Key not in map.');
    }
  }

  @override
  void updateAll(V Function(K, V) update) {
    if (_delegate.isEmpty) return;
    final backup = _delegate.entries.toList();
    _delegate.updateAll(update);
    record(() => _delegate.addEntries(backup));
  }

  @override
  void clear() {
    if (_delegate.isEmpty) return;
    final backup = _delegate;
    _delegate = {};
    record(() => _delegate = backup);
  }
}
