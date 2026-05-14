import 'package:garden/garden.dart';
import 'package:test/test.dart';

void main() {
  late Garden garden;
  late SetLeaf<int> leaf;

  setUp(() {
    garden = Garden();
    leaf = garden.grow(SetLeaf({1, 2, 3}));
  });

  test('commit and rollback add()', () {
    garden.branch();
    leaf.add(4);
    garden.rollback();
    expect(leaf, equals({1, 2, 3}));

    garden.branch();
    leaf.add(4);
    garden.commit();
    expect(leaf, equals({1, 2, 3, 4}));
  });

  test('commit and rollback remove()', () {
    garden.branch();
    expect(leaf.remove(2), isTrue);
    garden.rollback();
    expect(leaf, equals({1, 2, 3}));

    garden.branch();
    leaf.remove(2);
    garden.commit();
    expect(leaf, equals({1, 3}));
  });

  test('commit and rollback addAll() with overlapping elements', () {
    garden.branch();
    leaf.addAll([2, 3, 4, 5]);
    expect(leaf, equals({1, 2, 3, 4, 5}));
    garden.rollback();
    expect(leaf, equals({1, 2, 3}));
  });

  test('commit and rollback removeAll()', () {
    garden.branch();
    leaf.removeAll([2, 3, 99]);
    garden.rollback();
    expect(leaf, equals({1, 2, 3}));

    garden.branch();
    leaf.removeAll([2, 3, 99]);
    garden.commit();
    expect(leaf, equals({1}));
  });

  test('removeAll with no matches is a no-op', () {
    garden.branch();
    leaf.removeAll([99, 100]);
    garden.rollback();
    expect(leaf, equals({1, 2, 3}));
  });

  test('commit and rollback removeWhere()', () {
    garden.branch();
    leaf.removeWhere((value) => value.isEven);
    garden.rollback();
    expect(leaf, equals({1, 2, 3}));

    garden.branch();
    leaf.removeWhere((value) => value.isEven);
    garden.commit();
    expect(leaf, equals({1, 3}));
  });

  test('rollback removeWhere() with multiple removals', () {
    final big = garden.grow(SetLeaf({0, 1, 2, 3, 4, 5}));
    garden.branch();
    big.removeWhere((value) => value.isEven);
    expect(big, equals({1, 3, 5}));
    garden.rollback();
    expect(big, equals({0, 1, 2, 3, 4, 5}));
  });

  test('rollback retainWhere()', () {
    garden.branch();
    leaf.retainWhere((value) => value.isOdd);
    expect(leaf, equals({1, 3}));
    garden.rollback();
    expect(leaf, equals({1, 2, 3}));
  });

  test('rollback retainAll()', () {
    garden.branch();
    leaf.retainAll([1, 3, 99]);
    expect(leaf, equals({1, 3}));
    garden.rollback();
    expect(leaf, equals({1, 2, 3}));
  });

  test('commit and rollback clear()', () {
    garden.branch();
    leaf.clear();
    garden.rollback();
    expect(leaf, equals({1, 2, 3}));

    garden.branch();
    leaf.clear();
    garden.commit();
    expect(leaf, isEmpty);
  });
}
