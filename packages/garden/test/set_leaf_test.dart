import 'package:garden/garden.dart';
import 'package:test/test.dart';

void main() {
  late Garden garden;
  late SetLeaf<int> leaf;

  setUp(() {
    garden = Garden();
    leaf = garden.grow(() => SetLeaf({1, 2, 3}));
  });

  test('commit and revert add()', () {
    garden.branch();
    leaf.add(4);
    garden.revert();
    expect(leaf, equals({1, 2, 3}));

    garden.branch();
    leaf.add(4);
    garden.commit();
    expect(leaf, equals({1, 2, 3, 4}));
  });

  test('commit and revert remove()', () {
    garden.branch();
    expect(leaf.remove(2), isTrue);
    garden.revert();
    expect(leaf, equals({1, 2, 3}));

    garden.branch();
    leaf.remove(2);
    garden.commit();
    expect(leaf, equals({1, 3}));
  });

  test('commit and revert addAll() with overlapping elements', () {
    garden.branch();
    leaf.addAll([2, 3, 4, 5]);
    expect(leaf, equals({1, 2, 3, 4, 5}));
    garden.revert();
    expect(leaf, equals({1, 2, 3}));
  });

  test('commit and revert removeAll()', () {
    garden.branch();
    leaf.removeAll([2, 3, 99]);
    garden.revert();
    expect(leaf, equals({1, 2, 3}));

    garden.branch();
    leaf.removeAll([2, 3, 99]);
    garden.commit();
    expect(leaf, equals({1}));
  });

  test('removeAll with no matches is a no-op', () {
    garden.branch();
    leaf.removeAll([99, 100]);
    garden.revert();
    expect(leaf, equals({1, 2, 3}));
  });

  test('commit and revert removeWhere()', () {
    garden.branch();
    leaf.removeWhere((value) => value.isEven);
    garden.revert();
    expect(leaf, equals({1, 2, 3}));

    garden.branch();
    leaf.removeWhere((value) => value.isEven);
    garden.commit();
    expect(leaf, equals({1, 3}));
  });

  test('revert removeWhere() with multiple removals', () {
    final big = garden.grow(() => SetLeaf({0, 1, 2, 3, 4, 5}));
    garden.branch();
    big.removeWhere((value) => value.isEven);
    expect(big, equals({1, 3, 5}));
    garden.revert();
    expect(big, equals({0, 1, 2, 3, 4, 5}));
  });

  test('revert retainWhere()', () {
    garden.branch();
    leaf.retainWhere((value) => value.isOdd);
    expect(leaf, equals({1, 3}));
    garden.revert();
    expect(leaf, equals({1, 2, 3}));
  });

  test('revert retainAll()', () {
    garden.branch();
    leaf.retainAll([1, 3, 99]);
    expect(leaf, equals({1, 3}));
    garden.revert();
    expect(leaf, equals({1, 2, 3}));
  });

  test('commit and revert clear()', () {
    garden.branch();
    leaf.clear();
    garden.revert();
    expect(leaf, equals({1, 2, 3}));

    garden.branch();
    leaf.clear();
    garden.commit();
    expect(leaf, isEmpty);
  });
}
