import 'package:dogs_core/dogs_core.dart';
import 'package:garden/garden.dart';
import 'package:garden_dogs/garden_dogs.dart';
import 'package:test/test.dart';

void main() {
  configureDogs(
    plugins: [
      GardenPlugin(),
    ],
  );

  late Garden garden;
  setUp(() => garden = Garden());

  test('ValueLeaf', () {
    final leaf = garden.grow(() => ValueLeaf(42));
    const tree = TypeTree1<ValueLeaf, int>();
    final native = dogs.toNative(leaf, tree: tree);
    final restored = garden.grow(() => dogs.fromNative<ValueLeaf<int>>(native, tree: tree));
    expect(restored.value, equals(42));
  });

  test('ListLeaf', () {
    final leaf = garden.grow(() => ListLeaf([1, 2, 3]));
    const tree = TypeTree1<ListLeaf, int>();
    final native = dogs.toNative(leaf, tree: tree);
    final restored = garden.grow(() => dogs.fromNative<ListLeaf<int>>(native, tree: tree));
    expect(restored, orderedEquals([1, 2, 3]));
  });

  test('SetLeaf', () {
    final leaf = garden.grow(() => SetLeaf({1, 2, 3}));
    const tree = TypeTree1<SetLeaf, int>();
    final native = dogs.toNative(leaf, tree: tree);
    final restored = garden.grow(() => dogs.fromNative<SetLeaf<int>>(native, tree: tree));
    expect(restored, containsAll([1, 2, 3]));
  });

  test('MapLeaf', () {
    final leaf = garden.grow(() => MapLeaf({'a': 1, 'b': 2}));
    const tree = TypeTree2<MapLeaf, String, int>();
    final native = dogs.toNative(leaf, tree: tree);
    final restored = garden.grow(() => dogs.fromNative<MapLeaf<String, int>>(native, tree: tree));
    expect(restored['a'], equals(1));
    expect(restored['b'], equals(2));
  });

  test('RngLeaf', () {
    final leaf = garden.grow(() => RngLeaf(42));
    leaf.nextInt();
    leaf.nextInt();
    final native = dogs.toNative<RngLeaf>(leaf);
    final restored = garden.grow(() => dogs.fromNative<RngLeaf>(native));
    expect(restored.nextInt(), equals(leaf.nextInt()));
  });
}
