import 'package:dogs_core/dogs_core.dart';
import 'package:garden/garden.dart';

abstract class _RelationLeafConverterBase<K, V, L extends RelationLeaf> extends NTreeArgConverter<L> {
  L _create();

  @override
  L deserialize(dynamic data, DogEngine engine) {
    final leaf = _create();

    for (final pair in data) {
      leaf.add(
        deserializeArg(pair[0], 0, engine),
        deserializeArg(pair[1], 1, engine),
      );
    }

    return leaf;
  }

  @override
  dynamic serialize(L leaf, DogEngine engine) {
    return [
      for (final (key, value) in leaf.pairs)
        [
          serializeArg(key, 0, engine),
          serializeArg(value, 1, engine),
        ],
    ];
  }

  @override
  Iterable<(dynamic, int)> traverse(dynamic value, DogEngine engine) sync* {
    final leaf = value as RelationLeaf;

    for (final (key, val) in leaf.pairs) {
      yield (key, 0);
      yield (val, 1);
    }
  }
}

class RelationLeafNNConverter<K, V> extends _RelationLeafConverterBase<K, V, RelationLeafNN> {
  @override
  RelationLeafNN<K, V> _create() => RelationLeafNN<K, V>();
}

class RelationLeaf1NConverter<K, V> extends _RelationLeafConverterBase<K, V, RelationLeaf1N> {
  @override
  RelationLeaf1N<K, V> _create() => RelationLeaf1N<K, V>();
}

class RelationLeafN1Converter<K, V> extends _RelationLeafConverterBase<K, V, RelationLeafN1> {
  @override
  RelationLeafN1<K, V> _create() => RelationLeafN1<K, V>();
}

class RelationLeaf11Converter<K, V> extends _RelationLeafConverterBase<K, V, RelationLeaf11> {
  @override
  RelationLeaf11<K, V> _create() => RelationLeaf11<K, V>();
}
