import 'package:garden/garden.dart';
import 'package:test/test.dart';

void main() {
  late Garden garden;
  late MapLeaf<String, int> leaf;

  setUp(() {
    garden = Garden();
    leaf = garden.grow(MapLeaf({'a': 1, 'b': 2}));
  });

  test('initial state', () {
    expect(leaf['a'], equals(1));
    expect(leaf['b'], equals(2));
    expect(leaf.containsKey('a'), isTrue);
    expect(leaf.containsValue(2), isTrue);
    expect(leaf.containsKey('z'), isFalse);
  });

  test('commit and rollback set', () {
    garden.branch();
    leaf['c'] = 3;
    garden.rollback();
    expect(leaf.containsKey('c'), isFalse);

    garden.branch();
    leaf['c'] = 3;
    garden.commit();
    expect(leaf['c'], equals(3));
  });

  test('commit and rollback overwrite existing key', () {
    garden.branch();
    leaf['a'] = 42;
    garden.rollback();
    expect(leaf['a'], equals(1));

    garden.branch();
    leaf['a'] = 42;
    garden.commit();
    expect(leaf['a'], equals(42));
  });

  test('commit and rollback remove()', () {
    garden.branch();
    expect(leaf.remove('a'), equals(1));
    garden.rollback();
    expect(leaf['a'], equals(1));

    garden.branch();
    leaf.remove('a');
    garden.commit();
    expect(leaf.containsKey('a'), isFalse);
  });

  test('rollback remove() with null value', () {
    final leaf = garden.grow(MapLeaf<String, int?>({'a': null}));
    garden.branch();
    expect(leaf.remove('a'), isNull);
    expect(leaf.containsKey('a'), isFalse);
    garden.rollback();
    expect(leaf.containsKey('a'), isTrue);
    expect(leaf['a'], isNull);
  });

  test('commit and rollback clear()', () {
    garden.branch();
    leaf.clear();
    garden.rollback();
    expect(Map.fromEntries(leaf.entries), equals({'a': 1, 'b': 2}));

    garden.branch();
    leaf.clear();
    garden.commit();
    expect(Map.fromEntries(leaf.entries), isEmpty);
  });

  test('commit and rollback update existing key', () {
    garden.branch();
    final updated = leaf.update('a', (value) => value + 1);
    expect(updated, equals(2));
    garden.rollback();
    expect(leaf['a'], equals(1));

    garden.branch();
    leaf.update('a', (value) => value + 1);
    garden.commit();
    expect(leaf['a'], equals(2));
  });

  test('commit and rollback updateAll()', () {
    garden.branch();
    leaf.updateAll((key, value) => value * 10);
    expect(leaf, equals({'a': 10, 'b': 20}));
    garden.rollback();
    expect(leaf, equals({'a': 1, 'b': 2}));

    garden.branch();
    leaf.updateAll((key, value) => value * 10);
    garden.commit();
    expect(leaf, equals({'a': 10, 'b': 20}));
  });

  test('commit and rollback addAll() with new and existing keys', () {
    garden.branch();
    leaf.addAll({'a': 99, 'c': 3});
    expect(leaf, equals({'a': 99, 'b': 2, 'c': 3}));
    garden.rollback();
    expect(leaf, equals({'a': 1, 'b': 2}));

    garden.branch();
    leaf.addAll({'a': 99, 'c': 3});
    garden.commit();
    expect(leaf, equals({'a': 99, 'b': 2, 'c': 3}));
  });

  test('commit and rollback addEntries()', () {
    garden.branch();
    leaf.addEntries([MapEntry('b', 99), MapEntry('d', 4)]);
    expect(leaf, equals({'a': 1, 'b': 99, 'd': 4}));
    garden.rollback();
    expect(leaf, equals({'a': 1, 'b': 2}));
  });

  test('commit and rollback removeWhere()', () {
    garden.branch();
    leaf.removeWhere((key, value) => value.isEven);
    garden.rollback();
    expect(leaf, equals({'a': 1, 'b': 2}));

    garden.branch();
    leaf.removeWhere((key, value) => value.isEven);
    garden.commit();
    expect(leaf, equals({'a': 1}));
  });

  test('commit and rollback update with ifAbsent', () {
    garden.branch();
    final updated = leaf.update('c', (value) => value + 1, ifAbsent: () => 5);
    expect(updated, equals(5));
    garden.rollback();
    expect(leaf.containsKey('c'), isFalse);

    garden.branch();
    leaf.update('c', (value) => value + 1, ifAbsent: () => 5);
    garden.commit();
    expect(leaf['c'], equals(5));
  });
}
