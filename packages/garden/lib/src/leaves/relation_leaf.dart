import 'package:garden/src/garden.dart';

/// A [Leaf] that stores bidirectional key-value pairs with forward and reverse
/// indexes, supporting 1-1, 1-N, N-1, and N-N relationships.
///
/// Use the concrete subclasses [RelationLeaf11], [RelationLeaf1N],
/// [RelationLeafN1], or [RelationLeafNN] for the appropriate cardinality.
sealed class RelationLeaf<K, V> with Leaf {
  RelationLeaf(
    Iterable<(K, V)>? data, {
    required bool uniqueKeys,
    required bool uniqueValues,
  }) : _uniqueKeys = uniqueKeys,
       _uniqueValues = uniqueValues {
    if (data != null) {
      for (final (key, value) in data) {
        add(key, value);
      }
    }
  }

  final bool _uniqueKeys;
  final bool _uniqueValues;
  Map<K, Set<V>> _forward = {};
  Map<V, Set<K>> _reverse = {};
  int _length = 0;

  bool _addRaw(K key, V value) {
    final added = (_forward[key] ??= {}).add(value);

    if (added) {
      (_reverse[value] ??= {}).add(key);
      _length += 1;
    }

    return added;
  }

  bool _removeRaw(K key, V value) {
    final fSet = _forward[key];
    if (fSet == null || !fSet.remove(value)) return false;
    if (fSet.isEmpty) _forward.remove(key);
    final rSet = _reverse[value]!;
    rSet.remove(key);
    if (rSet.isEmpty) _reverse.remove(value);
    _length -= 1;
    return true;
  }

  Set<V> _removeKeyRaw(K key) {
    final values = _forward.remove(key);
    if (values == null) return const {};

    _length -= values.length;

    for (final value in values) {
      final rSet = _reverse[value]!;
      rSet.remove(key);
      if (rSet.isEmpty) _reverse.remove(value);
    }

    return values;
  }

  Set<K> _removeValueRaw(V value) {
    final keys = _reverse.remove(value);
    if (keys == null) return const {};

    _length -= keys.length;

    for (final key in keys) {
      final fSet = _forward[key]!;
      fSet.remove(value);
      if (fSet.isEmpty) _forward.remove(key);
    }

    return keys;
  }

  void _checkCardinality(K key, V value) {
    if (_uniqueKeys && _forward.containsKey(key)) {
      throw ArgumentError.value(
        key,
        'key',
        'Key already has an association.',
      );
    }

    if (_uniqueValues && _reverse.containsKey(value)) {
      throw ArgumentError.value(
        value,
        'value',
        'Value already has an association.',
      );
    }
  }

  /// Adds a pair. Throws [ArgumentError] if it would violate the cardinality.
  void add(K key, V value) {
    if (containsPair(key, value)) return;
    _checkCardinality(key, value);
    _addRaw(key, value);
    record(() => _removeRaw(key, value));
  }

  /// Adds a pair, silently removing any conflicting associations first.
  void move(K key, V value) {
    if (containsPair(key, value)) return;
    final displaced = <(K, V)>[];

    if (_uniqueKeys) {
      final oldValues = _forward[key];

      if (oldValues != null) {
        for (final value in oldValues.toList()) {
          displaced.add((key, value));
        }
      }
    }

    if (_uniqueValues) {
      final oldKeys = _reverse[value];

      if (oldKeys != null) {
        for (final key in oldKeys.toList()) {
          displaced.add((key, value));
        }
      }
    }

    for (final (key, value) in displaced) {
      _removeRaw(key, value);
    }

    _addRaw(key, value);

    record(() {
      _removeRaw(key, value);

      for (final (key, value) in displaced) {
        _addRaw(key, value);
      }
    });
  }

  /// Removes a specific pair. Returns true if it existed.
  bool remove(K key, V value) {
    if (!_removeRaw(key, value)) return false;
    record(() => _addRaw(key, value));
    return true;
  }

  /// Removes all pairs for [key]. Returns the removed values.
  Set<V> removeKey(K key) {
    final removed = _removeKeyRaw(key);
    if (removed.isEmpty) return removed;

    record(() {
      _forward[key] = removed;
      _length += removed.length;

      for (final value in removed) {
        (_reverse[value] ??= {}).add(key);
      }
    });

    return removed;
  }

  /// Removes all pairs for [value]. Returns the removed keys.
  Set<K> removeValue(V value) {
    final removed = _removeValueRaw(value);
    if (removed.isEmpty) return removed;

    record(() {
      _reverse[value] = removed;
      _length += removed.length;

      for (final key in removed) {
        (_forward[key] ??= {}).add(value);
      }
    });

    return removed;
  }

  /// Removes all pairs.
  void clear() {
    if (_forward.isEmpty) return;
    final forwardBackup = _forward;
    final reverseBackup = _reverse;
    final lengthBackup = _length;
    _forward = {};
    _reverse = {};
    _length = 0;

    record(() {
      _forward = forwardBackup;
      _reverse = reverseBackup;
      _length = lengthBackup;
    });
  }

  bool containsKey(K key) => _forward.containsKey(key);
  bool containsValue(V value) => _reverse.containsKey(value);
  bool containsPair(K key, V value) => _forward[key]?.contains(value) ?? false;

  /// All (key, value) pairs in the relation.
  Iterable<(K, V)> get pairs sync* {
    for (final MapEntry(:key, value: values) in _forward.entries) {
      for (final value in values) {
        yield (key, value);
      }
    }
  }

  /// All keys that have at least one association.
  Iterable<K> get keys => _forward.keys;

  /// All values that have at least one association.
  Iterable<V> get values => _reverse.keys;

  /// The total number of pairs in the relation.
  int get length => _length;

  /// The number of distinct keys in the relation.
  int get keyCount => _forward.length;

  /// The number of distinct values in the relation.
  int get valueCount => _reverse.length;

  bool get isEmpty => _forward.isEmpty;
  bool get isNotEmpty => _forward.isNotEmpty;
}

/// A many-to-many [RelationLeaf]. No cardinality constraints.
class RelationLeafNN<K, V> extends RelationLeaf<K, V> {
  RelationLeafNN([super.data]) : super(uniqueKeys: false, uniqueValues: false);

  /// Returns the values associated with [key], or an empty iterable.
  Iterable<V> getValues(K key) => _forward[key] ?? const [];

  /// Returns the keys associated with [value], or an empty iterable.
  Iterable<K> getKeys(V value) => _reverse[value] ?? const [];
}

/// A one-to-many [RelationLeaf]. Each value belongs to at most one key.
class RelationLeaf1N<K, V> extends RelationLeaf<K, V> {
  RelationLeaf1N([super.data]) : super(uniqueKeys: false, uniqueValues: true);

  /// Returns the values associated with [key], or an empty iterable.
  Iterable<V> getValues(K key) => _forward[key] ?? const [];

  /// Returns the single key associated with [value], or null.
  K? getKey(V value) => _reverse[value]?.first;
}

/// A many-to-one [RelationLeaf]. Each key maps to at most one value.
class RelationLeafN1<K, V> extends RelationLeaf<K, V> {
  RelationLeafN1([super.data]) : super(uniqueKeys: true, uniqueValues: false);

  /// Returns the single value associated with [key], or null.
  V? getValue(K key) => _forward[key]?.first;

  /// Returns the keys associated with [value], or an empty iterable.
  Iterable<K> getKeys(V value) => _reverse[value] ?? const [];
}

/// A one-to-one [RelationLeaf]. Both keys and values are unique.
class RelationLeaf11<K, V> extends RelationLeaf<K, V> {
  RelationLeaf11([super.data]) : super(uniqueKeys: true, uniqueValues: true);

  /// Returns the single value associated with [key], or null.
  V? getValue(K key) => _forward[key]?.first;

  /// Returns the single key associated with [value], or null.
  K? getKey(V value) => _reverse[value]?.first;
}
