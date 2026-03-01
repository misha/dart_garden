import 'package:collection/collection.dart';
import 'package:garden/src/garden.dart';

/// A [Leaf] list implementation with branch-aware undo recording.
class ListLeaf<T> extends DelegatingList<T> with Leaf {
  ListLeaf([Iterable<T>? data]) : super(data?.toList() ?? <T>[]);

  @override
  void operator []=(int index, T value) {
    final backup = super[index];
    record(() => super[index] = backup);
    super[index] = value;
  }

  @override
  void add(T value) {
    super.add(value);
    record(super.removeLast);
  }

  @override
  void addAll(Iterable<T> iterable) {
    final start = length;
    super.addAll(iterable);
    final end = length;
    if (start == end) return;
    record(() => super.removeRange(start, end));
  }

  @override
  void insert(int index, T element) {
    super.insert(index, element);
    record(() => super.removeAt(index));
  }

  @override
  void insertAll(int index, Iterable<T> iterable) {
    final before = length;
    super.insertAll(index, iterable);
    final after = length;
    if (before == after) return;
    final count = after - before;
    record(() => super.removeRange(index, index + count));
  }

  @override
  bool remove(Object? value) {
    if (value is! T) return false;
    final index = super.indexOf(value);
    if (index == -1) return false;
    removeAt(index);
    return true;
  }

  @override
  T removeAt(int index) {
    final backup = super.removeAt(index);
    record(() => super.insert(index, backup));
    return backup;
  }

  @override
  void removeWhere(bool Function(T) test) {
    if (isEmpty) return;
    final backup = toList();
    final originalLength = length;
    var write = 0;

    for (var read = 0; read < originalLength; read += 1) {
      if (test(super[read])) continue;
      if (write != read) super[write] = super[read];
      write += 1;
    }

    if (write == originalLength) return;
    super.removeRange(write, originalLength);

    record(() {
      super.clear();
      super.addAll(backup);
    });
  }

  /// Like [removeWhere], but without copying the entire list for undo.
  ///
  /// Use this for large lists where the memory cost of a full backup is
  /// undesirable. Faster when removing 1-2 elements; for 3+ removals,
  /// [removeWhere] is faster due to its single-pass compaction.
  void removeWhereSparse(bool Function(T) test) {
    for (var i = length - 1; i >= 0; i -= 1) {
      if (test(super[i])) {
        final value = super.removeAt(i);
        record(() => super.insert(i, value));
      }
    }
  }

  @override
  T removeLast() {
    final backup = super.removeLast();
    record(() => super.add(backup));
    return backup;
  }

  @override
  void removeRange(int start, int end) {
    if (start == end) return;
    final backup = sublist(start, end);
    super.removeRange(start, end);
    record(() => super.insertAll(start, backup));
  }

  @override
  void clear() {
    if (isEmpty) return;
    final backup = toList();
    record(() => super.addAll(backup));
    super.clear();
  }
}
