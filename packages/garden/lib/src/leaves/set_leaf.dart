import 'dart:collection';

import 'package:garden/src/garden.dart';

/// A [Leaf] set implementation with branch-aware undo recording.
class SetLeaf<T> with SetMixin<T>, Leaf {
  SetLeaf([Iterable<T>? data]) : _delegate = data?.toSet() ?? <T>{};

  Set<T> _delegate;

  @override
  Iterator<T> get iterator => _delegate.iterator;

  @override
  int get length => _delegate.length;

  @override
  bool contains(Object? element) => _delegate.contains(element);

  @override
  T? lookup(Object? element) => _delegate.lookup(element);

  @override
  Set<T> toSet() => _delegate.toSet();

  @override
  bool add(T value) {
    if (_delegate.add(value)) {
      record(() => _delegate.remove(value));
      return true;
    } else {
      return false;
    }
  }

  @override
  void addAll(Iterable<T> elements) {
    final added = <T>[];

    for (final element in elements) {
      if (_delegate.add(element)) {
        added.add(element);
      }
    }

    if (added.isNotEmpty) {
      record(() => _delegate.removeAll(added));
    }
  }

  @override
  bool remove(Object? value) {
    if (_delegate.remove(value)) {
      record(() => _delegate.add(value as T));
      return true;
    } else {
      return false;
    }
  }

  @override
  void removeAll(Iterable<Object?> elements) {
    final removed = <T>[];

    for (final element in elements) {
      if (_delegate.remove(element)) {
        removed.add(element as T);
      }
    }

    if (removed.isNotEmpty) {
      record(() => _delegate.addAll(removed));
    }
  }

  @override
  void retainWhere(bool Function(T) test) {
    removeWhere((element) => !test(element));
  }

  @override
  void retainAll(Iterable<Object?> elements) {
    final keep = elements.toSet();
    removeWhere((element) => !keep.contains(element));
  }

  @override
  void removeWhere(bool Function(T) test) {
    final removed = where(test).toList();
    if (removed.isEmpty) return;
    _delegate.removeAll(removed);
    record(() => _delegate.addAll(removed));
  }

  @override
  void clear() {
    if (_delegate.isEmpty) return;
    final backup = _delegate;
    _delegate = {};
    record(() => _delegate = backup);
  }
}
