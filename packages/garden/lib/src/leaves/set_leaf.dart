import 'package:collection/collection.dart';
import 'package:garden/src/garden.dart';

/// A [Leaf] set implementation with branch-aware undo recording.
class SetLeaf<T> extends DelegatingSet<T> with Leaf {
  SetLeaf([Iterable<T>? data]) : super(data?.toSet() ?? <T>{});

  @override
  bool add(T value) {
    if (super.add(value)) {
      record(() => super.remove(value));
      return true;
    } else {
      return false;
    }
  }

  @override
  void addAll(Iterable<T> elements) {
    final added = <T>[];

    for (final element in elements) {
      if (super.add(element)) {
        added.add(element);
      }
    }

    if (added.isNotEmpty) {
      record(() => super.removeAll(added));
    }
  }

  @override
  bool remove(Object? value) {
    if (super.remove(value)) {
      record(() => super.add(value as T));
      return true;
    } else {
      return false;
    }
  }

  @override
  void removeAll(Iterable<Object?> elements) {
    final removed = <T>[];

    for (final element in elements) {
      if (super.remove(element)) {
        removed.add(element as T);
      }
    }

    if (removed.isNotEmpty) {
      record(() => super.addAll(removed));
    }
  }

  @override
  void removeWhere(bool Function(T) test) {
    final removed = where(test).toList();
    if (removed.isEmpty) return;
    super.removeAll(removed);
    record(() => super.addAll(removed));
  }

  @override
  void clear() {
    if (isEmpty) return;
    final backup = toList();
    record(() => super.addAll(backup));
    super.clear();
  }
}
