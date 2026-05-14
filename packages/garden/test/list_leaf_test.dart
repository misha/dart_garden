import 'package:garden/garden.dart';
import 'package:test/test.dart';

void main() {
  late Garden garden;
  late ListLeaf<int> leaf;

  setUp(() {
    garden = Garden();
    leaf = garden.grow(ListLeaf([1, 2, 3]));
  });

  test('commit and rollback add()', () {
    garden.branch();
    leaf.add(4);
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.add(4);
    garden.commit();
    expect(leaf, equals([1, 2, 3, 4]));
  });

  test('commit and rollback remove()', () {
    garden.branch();
    expect(leaf.remove(2), isTrue);
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    expect(leaf.remove(2), isTrue);
    garden.commit();
    expect(leaf, equals([1, 3]));
  });

  test('commit and rollback addAll()', () {
    garden.branch();
    leaf.addAll([4, 5]);
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.addAll([4, 5]);
    garden.commit();
    expect(leaf, equals([1, 2, 3, 4, 5]));
  });

  test('commit and rollback clear()', () {
    garden.branch();
    leaf.clear();
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.clear();
    garden.commit();
    expect(leaf, isEmpty);
  });

  test('commit and rollback removeAt()', () {
    garden.branch();
    expect(leaf.removeAt(1), equals(2));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    expect(leaf.removeAt(1), equals(2));
    garden.commit();
    expect(leaf, equals([1, 3]));
  });

  test('commit and rollback removeRange()', () {
    garden.branch();
    leaf.removeRange(0, 2);
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.removeRange(0, 2);
    garden.commit();
    expect(leaf, equals([3]));
  });

  test('removeRange with empty range is a no-op', () {
    garden.branch();
    leaf.removeRange(1, 1);
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });

  test('commit and rollback removeWhere()', () {
    garden.branch();
    leaf.removeWhere((value) => value.isEven);
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.removeWhere((value) => value.isEven);
    garden.commit();
    expect(leaf, equals([1, 3]));
  });

  test('rollback removeWhere() with multiple removals', () {
    final big = garden.grow(ListLeaf([0, 1, 2, 3, 4, 5]));
    garden.branch();
    big.removeWhere((value) => value.isEven);
    expect(big, equals([1, 3, 5]));
    garden.rollback();
    expect(big, equals([0, 1, 2, 3, 4, 5]));
  });

  test('commit and rollback removeWhereSparse()', () {
    garden.branch();
    leaf.removeWhereSparse((value) => value.isEven);
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.removeWhereSparse((value) => value.isEven);
    garden.commit();
    expect(leaf, equals([1, 3]));
  });

  test('rollback removeWhereSparse() with multiple removals', () {
    final big = garden.grow(ListLeaf([0, 1, 2, 3, 4, 5]));
    garden.branch();
    big.removeWhereSparse((value) => value.isEven);
    expect(big, equals([1, 3, 5]));
    garden.rollback();
    expect(big, equals([0, 1, 2, 3, 4, 5]));
  });

  test('rollback insert()', () {
    garden.branch();
    leaf.insert(1, 99);
    expect(leaf, equals([1, 99, 2, 3]));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });

  test('rollback insertAll()', () {
    garden.branch();
    leaf.insertAll(1, [88, 99]);
    expect(leaf, equals([1, 88, 99, 2, 3]));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });

  test('rollback retainWhere()', () {
    garden.branch();
    leaf.retainWhere((value) => value.isOdd);
    expect(leaf, equals([1, 3]));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });

  test('rollback sort()', () {
    final unsorted = garden.grow(ListLeaf([3, 1, 2]));
    garden.branch();
    unsorted.sort();
    expect(unsorted, equals([1, 2, 3]));
    garden.rollback();
    expect(unsorted, equals([3, 1, 2]));
  });

  test('rollback shuffle()', () {
    final big = garden.grow(ListLeaf([1, 2, 3, 4, 5, 6, 7, 8]));
    final original = big.toList();
    garden.branch();
    big.shuffle();
    garden.rollback();
    expect(big, equals(original));
  });

  test('rollback first=', () {
    garden.branch();
    leaf.first = 99;
    expect(leaf, equals([99, 2, 3]));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });

  test('rollback last=', () {
    garden.branch();
    leaf.last = 99;
    expect(leaf, equals([1, 2, 99]));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });

  test('rollback setAll()', () {
    garden.branch();
    leaf.setAll(1, [88, 99]);
    expect(leaf, equals([1, 88, 99]));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });

  test('rollback setRange()', () {
    garden.branch();
    leaf.setRange(0, 2, [88, 99]);
    expect(leaf, equals([88, 99, 3]));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });

  test('rollback fillRange()', () {
    garden.branch();
    leaf.fillRange(0, 2, 0);
    expect(leaf, equals([0, 0, 3]));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });

  test('rollback replaceRange()', () {
    garden.branch();
    leaf.replaceRange(0, 2, [88, 99, 100]);
    expect(leaf, equals([88, 99, 100, 3]));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });

  test('rollback length=', () {
    garden.branch();
    leaf.length = 2;
    expect(leaf, equals([1, 2]));
    garden.rollback();
    expect(leaf, equals([1, 2, 3]));
  });
}
