// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unused_field, unused_import, unnecessary_import, public_member_api_docs, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

import 'dart:core';
import 'package:dogs_core/dogs_core.dart' as gen;
import 'package:lyell/lyell.dart' as gen;
import 'dart:core' as gen0;
import 'package:example_tictactoe/position.dart' as gen1;
import 'package:dogs_core/src/annotations.dart' as gen2;
import 'package:example_tictactoe/position.dart';

class PositionConverter extends gen.DefaultStructureConverter<gen1.Position> {
  PositionConverter()
    : super(
        struct: const gen.DogStructure<gen1.Position>(
          'Position',
          gen.StructureConformity.dataclass,
          [gen.DogStructureField(gen.QualifiedTerminal<gen0.int>(), null, 'x', false, false, []), gen.DogStructureField(gen.QualifiedTerminal<gen0.int>(), null, 'y', false, false, [])],
          [gen2.serializable],
          gen.ObjectFactoryStructureProxy<gen1.Position>(_activator, [_$x, _$y], _values, _hash, _equals),
        ),
      );

  static dynamic _$x(gen1.Position obj) => obj.x;

  static dynamic _$y(gen1.Position obj) => obj.y;

  static List<dynamic> _values(gen1.Position obj) => [obj.x, obj.y];

  static gen1.Position _activator(List list) {
    return gen1.Position(list[0], list[1]);
  }

  static int _hash(gen1.Position obj) => obj.x.hashCode ^ obj.y.hashCode;

  static bool _equals(gen1.Position a, gen1.Position b) => (a.x == b.x && a.y == b.y);
}

abstract class Position$Copy {
  gen1.Position call({gen0.int? x, gen0.int? y});
}

class PositionBuilder implements Position$Copy {
  PositionBuilder([gen1.Position? $src]) {
    if ($src == null) {
      $values = List.filled(2, null);
    } else {
      $values = PositionConverter._values($src);
      this.$src = $src;
    }
  }

  late List<dynamic> $values;

  gen1.Position? $src;

  set x(gen0.int value) {
    $values[0] = value;
  }

  gen0.int get x => $values[0];

  set y(gen0.int value) {
    $values[1] = value;
  }

  gen0.int get y => $values[1];

  @override
  gen1.Position call({Object? x = #sentinel, Object? y = #sentinel}) {
    if (x != #sentinel) {
      this.x = x as gen0.int;
    }
    if (y != #sentinel) {
      this.y = y as gen0.int;
    }
    return build();
  }

  gen1.Position build() {
    var instance = PositionConverter._activator($values);

    return instance;
  }
}

extension PositionDogsExtension on gen1.Position {
  gen1.Position rebuild(Function(PositionBuilder b) f) {
    var builder = PositionBuilder(this);
    f(builder);
    return builder.build();
  }

  Position$Copy get copy => toBuilder();

  PositionBuilder toBuilder() {
    return PositionBuilder(this);
  }

  Map<String, dynamic> toNative() {
    return gen.dogs.convertObjectToNative(this, gen1.Position);
  }
}
