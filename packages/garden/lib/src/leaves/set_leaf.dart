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
      record(() => super.removeAll(elements));
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
    throw UnimplementedError();
  }

  @override
  void removeWhere(bool Function(T) test) {
    throw UnimplementedError();
  }

  @override
  void clear() {
    if (isEmpty) return;
    final backup = List<T>.unmodifiable(this);
    record(() => super.addAll(backup));
    super.clear();
  }
}
