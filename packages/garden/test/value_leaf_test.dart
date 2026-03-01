import 'package:garden/garden.dart';
import 'package:test/test.dart';

void main() {
  late Garden garden;
  late ValueLeaf<int> leaf;

  setUp(() {
    garden = Garden();
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
}
