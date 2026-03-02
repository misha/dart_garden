import 'dart:collection';
import 'dart:math';

import 'package:garden/src/garden.dart';

/// A [Leaf] list implementation with branch-aware undo recording.
class ListLeaf<T> with ListMixin<T>, Leaf {
  ListLeaf([Iterable<T>? data]) : _delegate = data?.toList() ?? [];

  List<T> _delegate;

  @override
  T operator [](int index) => _delegate[index];

  @override
  void operator []=(int index, T value) {
    final backup = _delegate[index];
    record(() => _delegate[index] = backup);
    _delegate[index] = value;
  }

  @override
  int get length => _delegate.length;

  @override
  set length(int newLength) {
    if (newLength < length) {
      final backup = _delegate.sublist(newLength);
      _delegate.length = newLength;
      record(() => _delegate.addAll(backup));
    } else {
      _delegate.length = newLength;
    }
  }

  @override
  void add(T value) {
    _delegate.add(value);
    record(_delegate.removeLast);
  }

  @override
  void addAll(Iterable<T> iterable) {
    final start = length;
    _delegate.addAll(iterable);
    final end = length;
    if (start == end) return;
    record(() => _delegate.removeRange(start, end));
  }

  @override
  void insert(int index, T element) {
    _delegate.insert(index, element);
    record(() => _delegate.removeAt(index));
  }

  @override
  void insertAll(int index, Iterable<T> iterable) {
    final before = length;
    _delegate.insertAll(index, iterable);
    final after = length;
    if (before == after) return;
    final count = after - before;
    record(() => _delegate.removeRange(index, index + count));
  }

  @override
  bool remove(Object? value) {
    if (value is! T) return false;
    final index = _delegate.indexOf(value);
    if (index == -1) return false;
    removeAt(index);
    return true;
  }

  @override
  T removeAt(int index) {
    final backup = _delegate.removeAt(index);
    record(() => _delegate.insert(index, backup));
    return backup;
  }

  @override
  void removeWhere(bool Function(T) test) {
    if (isEmpty) return;
    final backup = _delegate.toList();
    final originalLength = length;
    var write = 0;

    for (var read = 0; read < originalLength; read += 1) {
      if (test(_delegate[read])) continue;
      if (write != read) _delegate[write] = _delegate[read];
      write += 1;
    }

    if (write == originalLength) return;
    _delegate.removeRange(write, originalLength);

    record(() {
      _delegate.clear();
      _delegate.addAll(backup);
    });
  }

  @override
  void retainWhere(bool Function(T) test) {
    removeWhere((element) => !test(element));
  }

  @override
  void sort([int Function(T a, T b)? compare]) {
    final backup = _delegate.toList();
    _delegate.sort(compare);
    record(() => _delegate.setAll(0, backup));
  }

  @override
  void setAll(int index, Iterable<T> iterable) {
    final items = iterable.toList();
    final backup = _delegate.sublist(index, index + items.length);
    _delegate.setAll(index, items);
    record(() => _delegate.setAll(index, backup));
  }

  @override
  void setRange(int start, int end, Iterable<T> iterable, [int skipCount = 0]) {
    final backup = _delegate.sublist(start, end);
    _delegate.setRange(start, end, iterable, skipCount);
    record(() => _delegate.setRange(start, end, backup));
  }

  @override
  void fillRange(int start, int end, [T? fillValue]) {
    final backup = _delegate.sublist(start, end);
    _delegate.fillRange(start, end, fillValue);
    record(() => _delegate.setRange(start, end, backup));
  }

  @override
  void replaceRange(int start, int end, Iterable<T> replacements) {
    final backup = _delegate.sublist(start, end);
    final before = length;
    _delegate.replaceRange(start, end, replacements);
    final newEnd = end + length - before;

    record(() {
      _delegate.removeRange(start, newEnd);
      _delegate.insertAll(start, backup);
    });
  }

  @override
  void shuffle([Random? random]) {
    final backup = _delegate.toList();
    _delegate.shuffle(random);
    record(() => _delegate.setAll(0, backup));
  }

  /// Like [removeWhere], but without copying the entire list for undo.
  ///
  /// Use this for large lists where the memory cost of a full backup is
  /// undesirable. Faster when removing 1-2 elements; for 3+ removals,
  /// [removeWhere] is faster due to its single-pass compaction.
  void removeWhereSparse(bool Function(T) test) {
    for (var i = length - 1; i >= 0; i -= 1) {
      if (test(_delegate[i])) {
        final value = _delegate.removeAt(i);
        record(() => _delegate.insert(i, value));
      }
    }
  }

  @override
  T removeLast() {
    final backup = _delegate.removeLast();
    record(() => _delegate.add(backup));
    return backup;
  }

  @override
  void removeRange(int start, int end) {
    if (start == end) return;
    final backup = _delegate.sublist(start, end);
    _delegate.removeRange(start, end);
    record(() => _delegate.insertAll(start, backup));
  }

  @override
  void clear() {
    if (_delegate.isEmpty) return;
    final backup = _delegate;
    _delegate = [];
    record(() => _delegate = backup);
  }
}
