import 'package:garden/garden.dart';
import 'package:test/test.dart';

void main() {
  late Garden garden;
  late RngLeaf leaf;

  setUp(() {
    garden = Garden();
    leaf = garden.grow(RngLeaf(42));
  });

  RngLeaf reference(int draws, {int seed = 42}) {
    final other = Garden().grow(RngLeaf(seed));

    for (var draw = 0; draw < draws; draw += 1) {
      other.nextInt();
    }

    return other;
  }

  test('seeded leaf produces deterministic values', () {
    final other = garden.grow(RngLeaf(42));
    expect(leaf.nextInt(), equals(other.nextInt()));
    expect(leaf.nextDouble(), equals(other.nextDouble()));
    expect(leaf.nextBool(), equals(other.nextBool()));
  });

  test('different seeds produce different values', () {
    final other = garden.grow(RngLeaf(99));
    expect(leaf.nextInt(), isNot(equals(other.nextInt())));
  });

  test('save returns restorable state', () {
    leaf.nextInt();
    final state = leaf.save();
    final restored = garden.grow(RngLeaf.restore(state));
    expect(restored.nextInt(), equals(leaf.nextInt()));
  });

  test('a commit keeps every draw the branch made', () {
    garden.branch();
    leaf.nextInt();
    leaf.nextInt();
    garden.commit();

    expect(leaf.save(), equals(reference(2).save()));
  });

  test('a rollback undoes every draw the branch made', () {
    garden.branch();
    leaf.nextInt();
    leaf.nextInt();
    leaf.nextInt();
    garden.rollback();

    expect(leaf.save(), equals(reference(0).save()));
  });

  test('a rollback replays the sequence from where the branch opened', () {
    garden.branch();
    final a = leaf.nextInt();
    final b = leaf.nextInt();
    garden.rollback();

    expect(leaf.nextInt(), equals(a));
    expect(leaf.nextInt(), equals(b));
  });

  test('an inner rollback returns to the inner branch, not the outer', () {
    garden.branch();
    leaf.nextInt();

    garden.branch();
    final inner = leaf.save();
    leaf.nextInt();
    garden.rollback();

    expect(leaf.save(), equals(inner));

    garden.rollback();
    expect(leaf.save(), equals(reference(0).save()));
  });

  test('a rolled-back branch moves nothing, however deep or often', () {
    for (var depth = 1; depth <= 4; depth += 1) {
      final garden = Garden();
      final leaf = garden.grow(RngLeaf(7));

      for (var level = 0; level < depth; level += 1) {
        garden.branch();
        leaf.nextInt();
      }

      final state = leaf.save();

      for (var attempt = 0; attempt < 5; attempt += 1) {
        garden.branch();
        leaf.nextInt();
        leaf.nextInt();
        garden.rollback();

        expect(
          leaf.save(),
          equals(state),
          reason: 'depth $depth, attempt ${attempt + 1}',
        );
      }
    }
  });

  test('a rolled-back branch moves nothing after a commit', () {
    garden.branch();
    leaf.nextInt();
    garden.branch();
    leaf.nextInt();
    garden.branch();
    leaf.nextInt();
    garden.commit();

    final state = leaf.save();

    for (var attempt = 0; attempt < 3; attempt += 1) {
      garden.branch();
      leaf.nextInt();
      garden.rollback();

      expect(leaf.save(), equals(state), reason: 'attempt ${attempt + 1}');
    }
  });

  test('nested branches unwind one level at a time', () {
    final states = <int, List<int>>{};

    for (var depth = 1; depth <= 3; depth += 1) {
      garden.branch();
      states[depth] = leaf.save();
      leaf.nextInt();
    }

    for (var depth = 3; depth >= 1; depth -= 1) {
      garden.rollback();
      expect(leaf.save(), equals(states[depth]), reason: 'out of depth $depth');
    }
  });

  test('every draw kind is taken back', () {
    for (final draw in <void Function()>[
      leaf.nextInt,
      leaf.nextDouble,
      leaf.nextBool,
    ]) {
      final state = leaf.save();
      garden.branch();
      draw();
      draw();
      garden.rollback();

      expect(leaf.save(), equals(state));
    }
  });
}
