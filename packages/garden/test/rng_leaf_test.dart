import 'package:garden/garden.dart';
import 'package:test/test.dart';

void main() {
  late Garden garden;
  late RngLeaf leaf;

  setUp(() {
    garden = Garden();
    leaf = garden.grow(() => RngLeaf(42));
  });

  test('seeded leaf produces deterministic values', () {
    final other = garden.grow(() => RngLeaf(42));
    expect(leaf.nextInt(), equals(other.nextInt()));
    expect(leaf.nextDouble(), equals(other.nextDouble()));
    expect(leaf.nextBool(), equals(other.nextBool()));
  });

  test('different seeds produce different values', () {
    final other = garden.grow(() => RngLeaf(99));
    expect(leaf.nextInt(), isNot(equals(other.nextInt())));
  });

  test('can branch and commit', () {
    garden.branch();
    final a = leaf.nextInt();
    garden.commit();

    // Value was consumed; next call advances past it.
    expect(leaf.nextInt(), isNot(equals(a)));
  });

  test('revert restores RNG state', () {
    garden.branch();
    final a = leaf.nextInt();
    final b = leaf.nextInt();
    garden.revert();

    // After revert the generator replays the same sequence.
    expect(leaf.nextInt(), equals(a));
    expect(leaf.nextInt(), equals(b));
  });

  test('revert across multiple calls in same version records once', () {
    garden.branch();
    leaf.nextInt();
    leaf.nextInt();
    leaf.nextInt();
    final state = leaf.save();
    garden.revert();

    // State was captured at branch entry, not at each call.
    expect(leaf.save(), isNot(equals(state)));
  });

  test('save returns restorable state', () {
    leaf.nextInt();
    final state = leaf.save();
    final restored = garden.grow(() => RngLeaf.restore(state));
    expect(restored.nextInt(), equals(leaf.nextInt()));
  });

  test('nested branches revert independently', () {
    garden.branch();
    final a = leaf.nextInt();

    garden.branch();
    leaf.nextInt();
    garden.revert(); // inner revert

    // Should replay from inner branch point, not outer.
    expect(leaf.nextInt(), isNot(equals(a)));

    garden.revert(); // outer revert
    expect(leaf.nextInt(), equals(a));
  });
}
