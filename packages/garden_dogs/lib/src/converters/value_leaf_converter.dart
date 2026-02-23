import 'package:dogs_core/dogs_core.dart';
import 'package:garden/garden.dart';

class ValueLeafConverter<T> extends NTreeArgConverter<ValueLeaf> {
  @override
  ValueLeaf<T> deserialize(dynamic data, DogEngine engine) {
    if (data == null) return .new(null as T);
    return .new(deserializeArg(data, 0, engine));
  }

  @override
  dynamic serialize(ValueLeaf leaf, DogEngine engine) {
    return serializeArg(leaf.value, 0, engine);
  }

  @override
  Iterable<(dynamic, int)> traverse(dynamic value, DogEngine engine) sync* {
    assert(value is ValueLeaf);
    final leaf = value as ValueLeaf;
    yield (leaf.value, 0);
  }
}
