import 'dart:convert';

import 'package:dogs_core/dogs_core.dart';
import 'package:garden/garden.dart';

class RngLeafConverter extends SimpleDogConverter<RngLeaf> {
  RngLeafConverter() : super(serialName: 'RngLeaf');

  @override
  RngLeaf deserialize(value, DogEngine engine) {
    return RngLeaf.restore(base64Decode(value));
  }

  @override
  dynamic serialize(RngLeaf value, DogEngine engine) {
    return base64Encode(value.save());
  }
}
