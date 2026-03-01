import 'package:garden/garden.dart';
import 'package:test/test.dart';

void main() {
  late Garden garden;
  late ListLeaf<int> leaf;

  setUp(() {
    garden = Garden();
    leaf = garden.grow(() => ListLeaf([1, 2, 3]));
  });

  test('commit and revert add()', () {
    garden.branch();
    leaf.add(4);
    garden.revert();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.add(4);
    garden.commit();
    expect(leaf, equals([1, 2, 3, 4]));
  });

  test('commit and revert remove()', () {
    garden.branch();
    expect(leaf.remove(2), isTrue);
    garden.revert();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    expect(leaf.remove(2), isTrue);
    garden.commit();
    expect(leaf, equals([1, 3]));
  });

  test('commit and revert addAll()', () {
    garden.branch();
    leaf.addAll([4, 5]);
    garden.revert();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.addAll([4, 5]);
    garden.commit();
    expect(leaf, equals([1, 2, 3, 4, 5]));
  });

  test('commit and revert clear()', () {
    garden.branch();
    leaf.clear();
    garden.revert();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.clear();
    garden.commit();
    expect(leaf, isEmpty);
  });

  test('commit and revert removeAt()', () {
    garden.branch();
    expect(leaf.removeAt(1), equals(2));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    expect(leaf.removeAt(1), equals(2));
    garden.commit();
    expect(leaf, equals([1, 3]));
  });

  test('commit and revert removeRange()', () {
    garden.branch();
    leaf.removeRange(0, 2);
    garden.revert();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.removeRange(0, 2);
    garden.commit();
    expect(leaf, equals([3]));
  });

  test('removeRange with empty range is a no-op', () {
    garden.branch();
    leaf.removeRange(1, 1);
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });

  test('commit and revert removeWhere()', () {
    garden.branch();
    leaf.removeWhere((value) => value.isEven);
    garden.revert();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.removeWhere((value) => value.isEven);
    garden.commit();
    expect(leaf, equals([1, 3]));
  });

  test('revert removeWhere() with multiple removals', () {
    final big = garden.grow(() => ListLeaf([0, 1, 2, 3, 4, 5]));
    garden.branch();
    big.removeWhere((value) => value.isEven);
    expect(big, equals([1, 3, 5]));
    garden.revert();
    expect(big, equals([0, 1, 2, 3, 4, 5]));
  });

  test('commit and revert removeWhereSparse()', () {
    garden.branch();
    leaf.removeWhereSparse((value) => value.isEven);
    garden.revert();
    expect(leaf, equals([1, 2, 3]));

    garden.branch();
    leaf.removeWhereSparse((value) => value.isEven);
    garden.commit();
    expect(leaf, equals([1, 3]));
  });

  test('revert removeWhereSparse() with multiple removals', () {
    final big = garden.grow(() => ListLeaf([0, 1, 2, 3, 4, 5]));
    garden.branch();
    big.removeWhereSparse((value) => value.isEven);
    expect(big, equals([1, 3, 5]));
    garden.revert();
    expect(big, equals([0, 1, 2, 3, 4, 5]));
  });

  test('revert insert()',() {
    garden.branch();
    leaf.insert(1, 99);
    expect(leaf, equals([1, 99, 2, 3]));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });

  test('revert insertAll()',() {
    garden.branch();
    leaf.insertAll(1, [88, 99]);
    expect(leaf, equals([1, 88, 99, 2, 3]));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });

  test('revert retainWhere()', skip: 'unimplemented', () {
    garden.branch();
    leaf.retainWhere((value) => value.isOdd);
    expect(leaf, equals([1, 3]));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });

  test('revert sort()', skip: 'unimplemented', () {
    final unsorted = garden.grow(() => ListLeaf([3, 1, 2]));
    garden.branch();
    unsorted.sort();
    expect(unsorted, equals([1, 2, 3]));
    garden.revert();
    expect(unsorted, equals([3, 1, 2]));
  });

  test('revert shuffle()', skip: 'unimplemented', () {
    final big = garden.grow(() => ListLeaf([1, 2, 3, 4, 5, 6, 7, 8]));
    final original = big.toList();
    garden.branch();
    big.shuffle();
    garden.revert();
    expect(big, equals(original));
  });

  test('revert first=', () {
    garden.branch();
    leaf.first = 99;
    expect(leaf, equals([99, 2, 3]));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });

  test('revert last=', () {
    garden.branch();
    leaf.last = 99;
    expect(leaf, equals([1, 2, 99]));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });

  test('revert setAll()', skip: 'unimplemented', () {
    garden.branch();
    leaf.setAll(1, [88, 99]);
    expect(leaf, equals([1, 88, 99]));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });

  test('revert setRange()', skip: 'unimplemented', () {
    garden.branch();
    leaf.setRange(0, 2, [88, 99]);
    expect(leaf, equals([88, 99, 3]));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });

  test('revert fillRange()', skip: 'unimplemented', () {
    garden.branch();
    leaf.fillRange(0, 2, 0);
    expect(leaf, equals([0, 0, 3]));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });

  test('revert replaceRange()', skip: 'unimplemented', () {
    garden.branch();
    leaf.replaceRange(0, 2, [88, 99, 100]);
    expect(leaf, equals([88, 99, 100, 3]));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });

  test('revert length=', skip: 'unimplemented', () {
    garden.branch();
    leaf.length = 2;
    expect(leaf, equals([1, 2]));
    garden.revert();
    expect(leaf, equals([1, 2, 3]));
  });
}
