// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unused_field, unused_import, unnecessary_import, public_member_api_docs, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

import 'dart:core';
import 'package:dogs_core/dogs_core.dart' as gen;
import 'package:lyell/lyell.dart' as gen;
import 'dart:core' as gen0;
import 'package:example_tictactoe/entity.dart' as gen1;
import 'package:dogs_core/src/annotations.dart' as gen2;
import 'package:example_tictactoe/entity.dart';

class PlayerConverter extends gen.DefaultStructureConverter<gen1.Player> {
  PlayerConverter()
    : super(
        struct: const gen.DogStructure<gen1.Player>(
          'Player',
          gen.StructureConformity.dataclass,
          [gen.DogStructureField(gen.QualifiedTerminal<gen0.String>(), null, 'symbol', false, false, [])],
          [gen2.serializable],
          gen.ObjectFactoryStructureProxy<gen1.Player>(_activator, [_$symbol], _values, _hash, _equals),
        ),
      );

  static dynamic _$symbol(gen1.Player obj) => obj.symbol;

  static List<dynamic> _values(gen1.Player obj) => [obj.symbol];

  static gen1.Player _activator(List list) {
    return gen1.Player(list[0]);
  }

  static int _hash(gen1.Player obj) => obj.symbol.hashCode;

  static bool _equals(gen1.Player a, gen1.Player b) => (a.symbol == b.symbol);
}

abstract class Player$Copy {
  gen1.Player call({gen0.String? symbol});
}

class PlayerBuilder implements Player$Copy {
  PlayerBuilder([gen1.Player? $src]) {
    if ($src == null) {
      $values = List.filled(1, null);
    } else {
      $values = PlayerConverter._values($src);
      this.$src = $src;
    }
  }

  late List<dynamic> $values;

  gen1.Player? $src;

  set symbol(gen0.String value) {
    $values[0] = value;
  }

  gen0.String get symbol => $values[0];

  @override
  gen1.Player call({Object? symbol = #sentinel}) {
    if (symbol != #sentinel) {
      this.symbol = symbol as gen0.String;
    }
    return build();
  }

  gen1.Player build() {
    var instance = PlayerConverter._activator($values);

    return instance;
  }
}

extension PlayerDogsExtension on gen1.Player {
  gen1.Player rebuild(Function(PlayerBuilder b) f) {
    var builder = PlayerBuilder(this);
    f(builder);
    return builder.build();
  }

  Player$Copy get copy => toBuilder();

  PlayerBuilder toBuilder() {
    return PlayerBuilder(this);
  }

  Map<String, dynamic> toNative() {
    return gen.dogs.convertObjectToNative(this, gen1.Player);
  }
}

class PieceConverter extends gen.DefaultStructureConverter<gen1.Piece> {
  PieceConverter()
    : super(
        struct: const gen.DogStructure<gen1.Piece>(
          'Piece',
          gen.StructureConformity.dataclass,
          [gen.DogStructureField(gen.QualifiedTerminal<gen0.int>(), null, 'id', false, false, [])],
          [gen2.serializable],
          gen.ObjectFactoryStructureProxy<gen1.Piece>(_activator, [_$id], _values, _hash, _equals),
        ),
      );

  static dynamic _$id(gen1.Piece obj) => obj.id;

  static List<dynamic> _values(gen1.Piece obj) => [obj.id];

  static gen1.Piece _activator(List list) {
    return gen1.Piece(list[0]);
  }

  static int _hash(gen1.Piece obj) => obj.id.hashCode;

  static bool _equals(gen1.Piece a, gen1.Piece b) => (a.id == b.id);
}

abstract class Piece$Copy {
  gen1.Piece call({gen0.int? id});
}

class PieceBuilder implements Piece$Copy {
  PieceBuilder([gen1.Piece? $src]) {
    if ($src == null) {
      $values = List.filled(1, null);
    } else {
      $values = PieceConverter._values($src);
      this.$src = $src;
    }
  }

  late List<dynamic> $values;

  gen1.Piece? $src;

  set id(gen0.int value) {
    $values[0] = value;
  }

  gen0.int get id => $values[0];

  @override
  gen1.Piece call({Object? id = #sentinel}) {
    if (id != #sentinel) {
      this.id = id as gen0.int;
    }
    return build();
  }

  gen1.Piece build() {
    var instance = PieceConverter._activator($values);

    return instance;
  }
}

extension PieceDogsExtension on gen1.Piece {
  gen1.Piece rebuild(Function(PieceBuilder b) f) {
    var builder = PieceBuilder(this);
    f(builder);
    return builder.build();
  }

  Piece$Copy get copy => toBuilder();

  PieceBuilder toBuilder() {
    return PieceBuilder(this);
  }

  Map<String, dynamic> toNative() {
    return gen.dogs.convertObjectToNative(this, gen1.Piece);
  }
}
