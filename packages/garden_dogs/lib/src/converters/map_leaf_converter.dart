import 'package:dogs_core/dogs_core.dart';
import 'package:garden/garden.dart';

class MapLeafConverter<K, V> extends NTreeArgConverter<MapLeaf> {
  @override
  MapLeaf<K, V> deserialize(dynamic data, DogEngine engine) {
    final leaf = MapLeaf<K, V>();

    for (final entry in data) {
      final key = deserializeArg(entry[0], 0, engine);
      final value = deserializeArg(entry[1], 1, engine);
      leaf[key] = value;
    }

    return leaf;
  }

  @override
  dynamic serialize(MapLeaf leaf, DogEngine engine) {
    return [
      for (final entry in leaf.entries)
        [
          serializeArg(entry.key, 0, engine),
          serializeArg(entry.value, 1, engine),
        ],
    ];
  }

  @override
  Iterable<(dynamic, int)> traverse(dynamic value, DogEngine engine) sync* {
    final leaf = value as MapLeaf;

    for (final entry in leaf.entries) {
      yield (entry.key, 0);
      yield (entry.value, 1);
    }
  }
}
