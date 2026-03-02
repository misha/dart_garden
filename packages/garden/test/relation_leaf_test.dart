import 'package:garden/garden.dart';
import 'package:test/test.dart';

void main() {
  group('RelationLeafNN', () {
    late Garden garden;
    late RelationLeafNN<String, int> leaf;

    setUp(() {
      garden = Garden();
      leaf = garden.grow(() => RelationLeafNN([('a', 1), ('a', 2), ('b', 2)]));
    });

    test('initial state', () {
      expect(leaf.containsPair('a', 1), isTrue);
      expect(leaf.containsPair('a', 2), isTrue);
      expect(leaf.containsPair('b', 2), isTrue);
      expect(leaf.containsPair('b', 1), isFalse);
      expect(leaf.getValues('a'), equals({1, 2}));
      expect(leaf.getKeys(2), equals({'a', 'b'}));
      expect(leaf.length, equals(3));
    });

    test('add and revert', () {
      garden.branch();
      leaf.add('c', 3);
      expect(leaf.containsPair('c', 3), isTrue);
      garden.revert();
      expect(leaf.containsPair('c', 3), isFalse);
      expect(leaf.length, equals(3));
    });

    test('add and commit', () {
      garden.branch();
      leaf.add('c', 3);
      garden.commit();
      expect(leaf.containsPair('c', 3), isTrue);
      expect(leaf.length, equals(4));
    });

    test('add duplicate is a no-op', () {
      garden.branch();
      leaf.add('a', 1);
      garden.revert();
      expect(leaf.containsPair('a', 1), isTrue);
      expect(leaf.length, equals(3));
    });

    test('remove and revert', () {
      garden.branch();
      expect(leaf.remove('a', 1), isTrue);
      expect(leaf.containsPair('a', 1), isFalse);
      garden.revert();
      expect(leaf.containsPair('a', 1), isTrue);
    });

    test('remove non-existent pair', () {
      garden.branch();
      expect(leaf.remove('z', 99), isFalse);
      garden.revert();
      expect(leaf.length, equals(3));
    });

    test('removeKey and revert', () {
      garden.branch();
      final removed = leaf.removeKey('a');
      expect(removed, equals({1, 2}));
      expect(leaf.containsKey('a'), isFalse);
      expect(leaf.getKeys(1), isEmpty);
      expect(leaf.getKeys(2), equals({'b'}));
      garden.revert();
      expect(leaf.getValues('a'), equals({1, 2}));
      expect(leaf.getKeys(1), equals({'a'}));
    });

    test('removeValue and revert', () {
      garden.branch();
      final removed = leaf.removeValue(2);
      expect(removed, equals({'a', 'b'}));
      expect(leaf.containsValue(2), isFalse);
      garden.revert();
      expect(leaf.getKeys(2), equals({'a', 'b'}));
    });

    test('clear and revert', () {
      garden.branch();
      leaf.clear();
      expect(leaf.isEmpty, isTrue);
      garden.revert();
      expect(leaf.length, equals(3));
    });

    test('clear and commit', () {
      garden.branch();
      leaf.clear();
      garden.commit();
      expect(leaf.isEmpty, isTrue);
    });

    test('clear on empty is a no-op', () {
      final empty = garden.grow(() => RelationLeafNN<String, int>());
      garden.branch();
      empty.clear();
      garden.revert();
      expect(empty.isEmpty, isTrue);
    });

    test('pairs iteration', () {
      final allPairs = leaf.pairs.toSet();
      expect(allPairs, equals({('a', 1), ('a', 2), ('b', 2)}));
    });

    test('keys and values', () {
      expect(leaf.keys, containsAll(['a', 'b']));
      expect(leaf.values, containsAll([1, 2]));
    });

    test('nested branches revert independently', () {
      garden.branch();
      leaf.add('c', 3);

      garden.branch();
      leaf.add('d', 4);
      garden.revert();

      expect(leaf.containsPair('c', 3), isTrue);
      expect(leaf.containsPair('d', 4), isFalse);

      garden.revert();
      expect(leaf.containsPair('c', 3), isFalse);
      expect(leaf.length, equals(3));
    });
  });

  group('RelationLeaf11', () {
    late Garden garden;
    late RelationLeaf11<String, int> leaf;

    setUp(() {
      garden = Garden();
      leaf = garden.grow(() => RelationLeaf11([('a', 1), ('b', 2)]));
    });

    test('add throws on duplicate key', () {
      expect(() => leaf.add('a', 3), throwsArgumentError);
    });

    test('add throws on duplicate value', () {
      expect(() => leaf.add('c', 1), throwsArgumentError);
    });

    test('add duplicate pair is a no-op', () {
      leaf.add('a', 1);
      expect(leaf.length, equals(2));
    });

    test('move reassigns key', () {
      garden.branch();
      leaf.move('a', 3);
      expect(leaf.containsPair('a', 1), isFalse);
      expect(leaf.containsPair('a', 3), isTrue);
      expect(leaf.containsValue(1), isFalse);
      garden.revert();
      expect(leaf.containsPair('a', 1), isTrue);
      expect(leaf.containsPair('a', 3), isFalse);
    });

    test('move reassigns value', () {
      garden.branch();
      leaf.move('c', 1);
      expect(leaf.containsPair('a', 1), isFalse);
      expect(leaf.containsPair('c', 1), isTrue);
      garden.revert();
      expect(leaf.containsPair('a', 1), isTrue);
      expect(leaf.containsPair('c', 1), isFalse);
    });

    test('move with both conflicts', () {
      garden.branch();
      leaf.move('a', 2);
      expect(leaf.length, equals(1));
      expect(leaf.containsPair('a', 2), isTrue);
      garden.revert();
      expect(leaf.length, equals(2));
      expect(leaf.containsPair('a', 1), isTrue);
      expect(leaf.containsPair('b', 2), isTrue);
    });

    test('getValue and getKey', () {
      expect(leaf.getValue('a'), equals(1));
      expect(leaf.getKey(1), equals('a'));
      expect(leaf.getValue('z'), isNull);
      expect(leaf.getKey(99), isNull);
    });
  });

  group('RelationLeaf1N', () {
    late Garden garden;
    late RelationLeaf1N<String, int> leaf;

    setUp(() {
      garden = Garden();
      leaf = garden.grow(() => RelationLeaf1N([('a', 1), ('a', 2), ('b', 3)]));
    });

    test('allows multiple values per key', () {
      leaf.add('a', 4);
      expect(leaf.getValues('a'), equals({1, 2, 4}));
    });

    test('add throws on duplicate value (different key)', () {
      expect(() => leaf.add('b', 1), throwsArgumentError);
    });

    test('add duplicate pair is a no-op', () {
      leaf.add('a', 1);
      expect(leaf.length, equals(3));
    });

    test('move reassigns value to new key', () {
      garden.branch();
      leaf.move('b', 1);
      expect(leaf.containsPair('a', 1), isFalse);
      expect(leaf.containsPair('b', 1), isTrue);
      garden.revert();
      expect(leaf.containsPair('a', 1), isTrue);
      expect(leaf.containsPair('b', 1), isFalse);
    });

    test('getValues and getKey', () {
      expect(leaf.getValues('a'), equals({1, 2}));
      expect(leaf.getKey(1), equals('a'));
      expect(leaf.getKey(3), equals('b'));
      expect(leaf.getKey(99), isNull);
    });
  });

  group('RelationLeafN1', () {
    late Garden garden;
    late RelationLeafN1<String, int> leaf;

    setUp(() {
      garden = Garden();
      leaf = garden.grow(() => RelationLeafN1([('a', 1), ('b', 1), ('c', 2)]));
    });

    test('allows multiple keys per value', () {
      leaf.add('d', 1);
      expect(leaf.getKeys(1), equals({'a', 'b', 'd'}));
    });

    test('add throws on duplicate key (different value)', () {
      expect(() => leaf.add('a', 2), throwsArgumentError);
    });

    test('add duplicate pair is a no-op', () {
      leaf.add('a', 1);
      expect(leaf.length, equals(3));
    });

    test('move reassigns key to new value', () {
      garden.branch();
      leaf.move('a', 2);
      expect(leaf.containsPair('a', 1), isFalse);
      expect(leaf.containsPair('a', 2), isTrue);
      garden.revert();
      expect(leaf.containsPair('a', 1), isTrue);
      expect(leaf.containsPair('a', 2), isFalse);
    });

    test('getValue and getKeys', () {
      expect(leaf.getValue('a'), equals(1));
      expect(leaf.getValue('z'), isNull);
      expect(leaf.getKeys(1), equals({'a', 'b'}));
      expect(leaf.getKeys(2), equals({'c'}));
      expect(leaf.getKeys(99), isEmpty);
    });
  });
}
