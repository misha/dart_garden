import 'package:dogs_core/dogs_core.dart';
import 'package:garden/garden.dart';
import 'package:garden_dogs/src/converters/map_leaf_converter.dart';
import 'package:garden_dogs/src/converters/relation_leaf_converter.dart';
import 'package:garden_dogs/src/converters/rng_leaf_converter.dart';
import 'package:garden_dogs/src/converters/value_leaf_converter.dart';

final _valueLeafFactory = TreeBaseConverterFactory.createNargsFactory<ValueLeaf>(
  nargs: 1,
  consume: <T>() => ValueLeafConverter<T>(),
);

final _listLeafFactory = TreeBaseConverterFactory.createIterableFactory<ListLeaf>(
  wrap: <T>(Iterable<T> entries) => ListLeaf<T>(entries),
  unwrap: <T>(ListLeaf value) => value,
);

final _setLeafFactory = TreeBaseConverterFactory.createIterableFactory<SetLeaf>(
  wrap: <T>(Iterable<T> entries) => SetLeaf<T>(entries),
  unwrap: <T>(SetLeaf value) => value,
);

final _mapLeafFactory = TreeBaseConverterFactory.createNargsFactory<MapLeaf>(
  nargs: 2,
  consume: <K, V>() => MapLeafConverter<K, V>(),
);

final _relationLeafNNFactory = TreeBaseConverterFactory.createNargsFactory<RelationLeafNN>(
  nargs: 2,
  consume: <K, V>() => RelationLeafNNConverter<K, V>(),
);

final _relationLeaf1NFactory = TreeBaseConverterFactory.createNargsFactory<RelationLeaf1N>(
  nargs: 2,
  consume: <K, V>() => RelationLeaf1NConverter<K, V>(),
);

final _relationLeafN1Factory = TreeBaseConverterFactory.createNargsFactory<RelationLeafN1>(
  nargs: 2,
  consume: <K, V>() => RelationLeafN1Converter<K, V>(),
);

final _relationLeaf11Factory = TreeBaseConverterFactory.createNargsFactory<RelationLeaf11>(
  nargs: 2,
  consume: <K, V>() => RelationLeaf11Converter<K, V>(),
);

DogPlugin GardenPlugin() => (engine) {
  engine.registerAllConverters([
    RngLeafConverter(),
  ]);

  engine.registerAllTreeBaseFactories([
    MapEntry(TypeToken<ValueLeaf>(), _valueLeafFactory),
    MapEntry(TypeToken<ListLeaf>(), _listLeafFactory),
    MapEntry(TypeToken<SetLeaf>(), _setLeafFactory),
    MapEntry(TypeToken<MapLeaf>(), _mapLeafFactory),
    MapEntry(TypeToken<RelationLeafNN>(), _relationLeafNNFactory),
    MapEntry(TypeToken<RelationLeaf1N>(), _relationLeaf1NFactory),
    MapEntry(TypeToken<RelationLeafN1>(), _relationLeafN1Factory),
    MapEntry(TypeToken<RelationLeaf11>(), _relationLeaf11Factory),
  ]);
};
