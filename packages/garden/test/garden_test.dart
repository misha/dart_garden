import 'package:garden/garden.dart';
import 'package:test/test.dart';

void main() {
  late Garden garden;

  setUp(() {
    garden = Garden();
  });

  group('value leaf', () {
    late ValueLeaf<int> leaf;

    setUp(() {
      leaf = garden.grow(() => ValueLeaf(1));
    });

    test('initial value', () {
      expect(leaf.value, equals(1));
    });

    test('permits direct mutation', () {
      leaf.value += 1;
      expect(leaf.value, equals(2));
    });

    test('can branch and commit', () {
      garden.branch();
      leaf.value += 1;
      garden.commit();
      expect(leaf.value, equals(2));
      expect(garden.isBranched, isFalse);
    });

    test('can branch and revert', () {
      garden.branch();
      leaf.value += 1;
      garden.revert();
      expect(leaf.value, equals(1));
      expect(garden.isBranched, isFalse);
    });
  });

  group('list leaf', () {
    late ListLeaf<int> leaf;

    setUp(() {
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
  });

  group('set leaf', () {
    late SetLeaf<int> leaf;

    setUp(() {
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
  });

  group('map leaf', () {
    late MapLeaf<String, int> leaf;

    setUp(() {
      leaf = garden.grow(() => MapLeaf({'a': 1, 'b': 2}));
    });

    test('initial state', () {
      expect(leaf['a'], equals(1));
      expect(leaf['b'], equals(2));
      expect(leaf.containsKey('a'), isTrue);
      expect(leaf.containsValue(2), isTrue);
      expect(leaf.containsKey('z'), isFalse);
    });

    test('commit and revert set', () {
      garden.branch();
      leaf['c'] = 3;
      garden.revert();
      expect(leaf.containsKey('c'), isFalse);

      garden.branch();
      leaf['c'] = 3;
      garden.commit();
      expect(leaf['c'], equals(3));
    });

    test('commit and revert overwrite existing key', () {
      garden.branch();
      leaf['a'] = 42;
      garden.revert();
      expect(leaf['a'], equals(1));

      garden.branch();
      leaf['a'] = 42;
      garden.commit();
      expect(leaf['a'], equals(42));
    });

    test('commit and revert remove()', () {
      garden.branch();
      expect(leaf.remove('a'), equals(1));
      garden.revert();
      expect(leaf['a'], equals(1));

      garden.branch();
      leaf.remove('a');
      garden.commit();
      expect(leaf.containsKey('a'), isFalse);
    });

    test('commit and revert clear()', () {
      garden.branch();
      leaf.clear();
      garden.revert();
      expect(Map.fromEntries(leaf.entries), equals({'a': 1, 'b': 2}));

      garden.branch();
      leaf.clear();
      garden.commit();
      expect(Map.fromEntries(leaf.entries), isEmpty);
    });

    test('commit and revert update existing key', () {
      garden.branch();
      final updated = leaf.update('a', (value) => value + 1);
      expect(updated, equals(2));
      garden.revert();
      expect(leaf['a'], equals(1));

      garden.branch();
      leaf.update('a', (value) => value + 1);
      garden.commit();
      expect(leaf['a'], equals(2));
    });

    test('commit and revert updateAll()', () {
      garden.branch();
      leaf.updateAll((key, value) => value * 10);
      expect(leaf, equals({'a': 10, 'b': 20}));
      garden.revert();
      expect(leaf, equals({'a': 1, 'b': 2}));

      garden.branch();
      leaf.updateAll((key, value) => value * 10);
      garden.commit();
      expect(leaf, equals({'a': 10, 'b': 20}));
    });

    test('commit and revert update with ifAbsent', () {
      garden.branch();
      final updated = leaf.update('c', (value) => value + 1, ifAbsent: () => 5);
      expect(updated, equals(5));
      garden.revert();
      expect(leaf.containsKey('c'), isFalse);

      garden.branch();
      leaf.update('c', (value) => value + 1, ifAbsent: () => 5);
      garden.commit();
      expect(leaf['c'], equals(5));
    });
  });
}
