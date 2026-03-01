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
  bool remove(Object? value) {
    if (value is! T) return false;
    final index = super.indexOf(value);
    if (index == -1) return false;
    super.removeAt(index);
    record(() => super.insert(index, value));
    return true;
  }

  @override
  T removeAt(int index) {
    throw UnimplementedError();
  }

  @override
  void removeWhere(bool Function(T) test) {
    if (isEmpty) return;
    final originalLength = length;
    ({List<int> indices, List<T> values})? removed;
    var write = 0;

    for (var read = 0; read < originalLength; read += 1) {
      final value = super[read];

      if (test(value)) {
        removed ??= (indices: [], values: []);
        removed.indices.add(read);
        removed.values.add(value);
        continue;
      }

      if (write != read) super[write] = value;
      write += 1;
    }

    if (removed == null) return;
    final indices = removed.indices;
    final values = removed.values;

    record(() {
      for (var i = 0; i < indices.length; i += 1) {
        super.insert(indices[i], values[i]);
      }
    });

    super.removeRange(write, originalLength);
  }

  @override
  T removeLast() {
    final value = super.removeLast();
    record(() => super.add(value));
    return value;
  }

  @override
  void removeRange(int start, int end) {
    throw UnimplementedError();
  }

  @override
  void clear() {
    if (isEmpty) return;
    final backup = toList();
    record(() => super.addAll(backup));
    super.clear();
  }
}
