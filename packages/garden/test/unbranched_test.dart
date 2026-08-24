import 'dart:math';

import 'package:garden/garden.dart';
import 'package:test/test.dart';

void same<T extends Leaf>(
  String name,
  T Function() build,
  void Function(T leaf) mutate, {
  Object? Function(T leaf)? read,
}) {
  final look = read ?? (leaf) => '$leaf';

  test(name, () {
    final open = Garden();
    final plain = open.grow(build());
    mutate(plain);
    expect(open.isBranched, isFalse, reason: 'the plain route left a branch');

    final closed = Garden();
    final tracked = closed.grow(build());
    closed.branch();
    mutate(tracked);
    closed.commit();

    expect(look(plain), look(tracked));
  });
}

void main() {
  group('value', () {
    same(
      'set',
      () => ValueLeaf(1),
      (leaf) => leaf.value = 9,
      read: (leaf) => leaf.value,
    );
  });

  group('list', () {
    ListLeaf<int> build() => ListLeaf([1, 2, 3, 4, 5, 6]);

    same('set', build, (leaf) => leaf[2] = 9);
    // Growing fills with null, which a list of ints cannot hold.
    same('grow', () => ListLeaf<int?>([1, 2, 3]), (leaf) => leaf.length = 6);
    same('shrink', build, (leaf) => leaf.length = 2);
    same('add', build, (leaf) => leaf.add(9));
    same('addAll', build, (leaf) => leaf.addAll([9, 10]));
    same('insert', build, (leaf) => leaf.insert(1, 9));
    same('insertAll', build, (leaf) => leaf.insertAll(1, [9, 10]));
    same('remove', build, (leaf) => leaf.remove(3));
    same('remove a stranger', build, (leaf) => leaf.remove(99));
    same('removeAt', build, (leaf) => leaf.removeAt(1));
    same('removeWhere', build, (leaf) => leaf.removeWhere((v) => v.isEven));
    same('removeWhere nothing', build, (leaf) => leaf.removeWhere((v) => false));
    same('removeWhereSparse', build, (leaf) => leaf.removeWhereSparse((v) => v == 3));
    same('retainWhere', build, (leaf) => leaf.retainWhere((v) => v.isOdd));
    same('sort', build, (leaf) => leaf.sort((a, b) => b - a));
    same('setAll', build, (leaf) => leaf.setAll(1, [8, 9]));
    same('setRange', build, (leaf) => leaf.setRange(1, 3, [8, 9]));
    same('fillRange', build, (leaf) => leaf.fillRange(1, 4, 0));
    same('replaceRange', build, (leaf) => leaf.replaceRange(1, 3, [7, 8, 9]));
    same('shuffle', build, (leaf) => leaf.shuffle(Random(1)));
    same('removeLast', build, (leaf) => leaf.removeLast());
    same('removeRange', build, (leaf) => leaf.removeRange(1, 3));
    same('removeRange empty', build, (leaf) => leaf.removeRange(2, 2));
    same('clear', build, (leaf) => leaf.clear());
  });

  group('set', () {
    SetLeaf<int> build() => SetLeaf({1, 2, 3, 4});

    same('add', build, (leaf) => leaf.add(9));
    same('add a duplicate', build, (leaf) => leaf.add(2));
    same('addAll', build, (leaf) => leaf.addAll([3, 9, 10]));
    same('remove', build, (leaf) => leaf.remove(2));
    same('remove a stranger', build, (leaf) => leaf.remove(99));
    same('removeAll', build, (leaf) => leaf.removeAll([1, 2, 99]));
    same('removeWhere', build, (leaf) => leaf.removeWhere((v) => v.isEven));
    same('retainWhere', build, (leaf) => leaf.retainWhere((v) => v.isOdd));
    same('retainAll', build, (leaf) => leaf.retainAll([1, 3]));
    same('clear', build, (leaf) => leaf.clear());
  });

  group('map', () {
    MapLeaf<int, int> build() => MapLeaf({1: 1, 2: 2, 3: 3});

    same('set', build, (leaf) => leaf[2] = 9);
    same('set a new key', build, (leaf) => leaf[9] = 9);
    same('addAll', build, (leaf) => leaf.addAll({2: 8, 9: 9}));
    same('addEntries', build, (leaf) => leaf.addEntries([.new(2, 8), .new(9, 9)]));
    same('remove', build, (leaf) => leaf.remove(2));
    same('remove a stranger', build, (leaf) => leaf.remove(99));
    same('removeWhere', build, (leaf) => leaf.removeWhere((k, v) => v.isEven));
    same('update', build, (leaf) => leaf.update(2, (v) => v * 10));
    same('update ifAbsent', build, (leaf) => leaf.update(9, (v) => v, ifAbsent: () => 9));
    same('updateAll', build, (leaf) => leaf.updateAll((k, v) => v * 10));
    same('clear', build, (leaf) => leaf.clear());
  });

  group('relation', () {
    RelationLeafNN<int, String> build() {
      return RelationLeafNN([(1, 'a'), (1, 'b'), (2, 'c')]);
    }

    String show(RelationLeafNN<int, String> leaf) {
      final keys = leaf.keys.toList()..sort();
      return [
        for (final key in keys) //
          '$key=${(leaf.getValues(key).toList()..sort()).join()}',
      ].join(' ');
    }

    same('add', build, (leaf) => leaf.add(3, 'd'), read: show);
    same('add a duplicate', build, (leaf) => leaf.add(1, 'a'), read: show);
    same('move', build, (leaf) => leaf.move(2, 'a'), read: show);
    same('remove', build, (leaf) => leaf.remove(1, 'a'), read: show);
    same('remove a stranger', build, (leaf) => leaf.remove(9, 'z'), read: show);
    same('removeKey', build, (leaf) => leaf.removeKey(1), read: show);
    same('removeValue', build, (leaf) => leaf.removeValue('a'), read: show);
    same('clear', build, (leaf) => leaf.clear(), read: show);

    same(
      'length survives clear',
      build,
      (leaf) => leaf.clear(),
      read: (leaf) => leaf.length,
    );
  });
}
