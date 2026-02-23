// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unused_field, unused_import, unnecessary_import, public_member_api_docs, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

import 'dart:core';
import 'package:dogs_core/dogs_core.dart' as gen;
import 'package:lyell/lyell.dart' as gen;
import 'package:garden/src/leaves/value_leaf.dart' as gen0;
import 'dart:core' as gen1;
import 'package:garden/src/leaves/map_leaf.dart' as gen2;
import 'package:example_tictactoe/position.dart' as gen3;
import 'package:example_tictactoe/entity.dart' as gen4;
import 'package:example_tictactoe/result.dart' as gen5;
import 'package:dogs_core/src/annotations.dart' as gen6;
import 'package:example_tictactoe/database.dart' as gen7;
import 'package:example_tictactoe/database.dart';

class TicTacToeDatabaseConverter extends gen.DefaultStructureConverter<gen7.TicTacToeDatabase> {
  TicTacToeDatabaseConverter()
    : super(
        struct: const gen.DogStructure<gen7.TicTacToeDatabase>(
          'TicTacToeDatabase',
          gen.StructureConformity.dataclass,
          [
            gen.DogStructureField(gen.QualifiedTypeTreeN<gen0.ValueLeaf<gen1.int>, gen0.ValueLeaf<dynamic>>([gen.QualifiedTerminal<gen1.int>()]), null, 'serial', false, true, []),
            gen.DogStructureField(gen.QualifiedTypeTreeN<gen0.ValueLeaf<gen1.int>, gen0.ValueLeaf<dynamic>>([gen.QualifiedTerminal<gen1.int>()]), null, 'turn', false, true, []),
            gen.DogStructureField(
              gen.QualifiedTypeTreeN<gen2.MapLeaf<gen3.Position, gen4.Piece>, gen2.MapLeaf<dynamic, dynamic>>([gen.QualifiedTerminal<gen3.Position>(), gen.QualifiedTerminal<gen4.Piece>()]),
              null,
              'contents',
              false,
              true,
              [],
            ),
            gen.DogStructureField(
              gen.QualifiedTypeTreeN<gen2.MapLeaf<gen4.Piece, gen4.Player>, gen2.MapLeaf<dynamic, dynamic>>([gen.QualifiedTerminal<gen4.Piece>(), gen.QualifiedTerminal<gen4.Player>()]),
              null,
              'owners',
              false,
              true,
              [],
            ),
            gen.DogStructureField(gen.QualifiedTypeTreeN<gen0.ValueLeaf<gen5.Result>, gen0.ValueLeaf<dynamic>>([gen.QualifiedTerminal<gen5.Result>()]), null, 'result', false, true, [
              gen6.polymorphic,
            ]),
          ],
          [gen6.serializable],
          gen.ObjectFactoryStructureProxy<gen7.TicTacToeDatabase>(_activator, [_$serial, _$turn, _$contents, _$owners, _$result], _values, _hash, _equals),
        ),
      );

  static dynamic _$serial(gen7.TicTacToeDatabase obj) => obj.serial;

  static dynamic _$turn(gen7.TicTacToeDatabase obj) => obj.turn;

  static dynamic _$contents(gen7.TicTacToeDatabase obj) => obj.contents;

  static dynamic _$owners(gen7.TicTacToeDatabase obj) => obj.owners;

  static dynamic _$result(gen7.TicTacToeDatabase obj) => obj.result;

  static List<dynamic> _values(gen7.TicTacToeDatabase obj) => [obj.serial, obj.turn, obj.contents, obj.owners, obj.result];

  static gen7.TicTacToeDatabase _activator(List list) {
    return gen7.TicTacToeDatabase(serial: list[0], turn: list[1], contents: list[2], owners: list[3], result: list[4]);
  }

  static int _hash(gen7.TicTacToeDatabase obj) => obj.serial.hashCode ^ obj.turn.hashCode ^ gen.deepEquality.hash(obj.contents) ^ gen.deepEquality.hash(obj.owners) ^ obj.result.hashCode;

  static bool _equals(gen7.TicTacToeDatabase a, gen7.TicTacToeDatabase b) =>
      (a.serial == b.serial && a.turn == b.turn && gen.deepEquality.equals(a.contents, b.contents) && gen.deepEquality.equals(a.owners, b.owners) && a.result == b.result);
}

abstract class TicTacToeDatabase$Copy {
  gen7.TicTacToeDatabase call({
    gen0.ValueLeaf<gen1.int>? serial,
    gen0.ValueLeaf<gen1.int>? turn,
    gen2.MapLeaf<gen3.Position, gen4.Piece>? contents,
    gen2.MapLeaf<gen4.Piece, gen4.Player>? owners,
    gen0.ValueLeaf<gen5.Result>? result,
  });
}

class TicTacToeDatabaseBuilder implements TicTacToeDatabase$Copy {
  TicTacToeDatabaseBuilder([gen7.TicTacToeDatabase? $src]) {
    if ($src == null) {
      $values = List.filled(5, null);
    } else {
      $values = TicTacToeDatabaseConverter._values($src);
      this.$src = $src;
    }
  }

  late List<dynamic> $values;

  gen7.TicTacToeDatabase? $src;

  set serial(gen0.ValueLeaf<gen1.int> value) {
    $values[0] = value;
  }

  gen0.ValueLeaf<gen1.int> get serial => $values[0];

  set turn(gen0.ValueLeaf<gen1.int> value) {
    $values[1] = value;
  }

  gen0.ValueLeaf<gen1.int> get turn => $values[1];

  set contents(gen2.MapLeaf<gen3.Position, gen4.Piece> value) {
    $values[2] = value;
  }

  gen2.MapLeaf<gen3.Position, gen4.Piece> get contents => $values[2];

  set owners(gen2.MapLeaf<gen4.Piece, gen4.Player> value) {
    $values[3] = value;
  }

  gen2.MapLeaf<gen4.Piece, gen4.Player> get owners => $values[3];

  set result(gen0.ValueLeaf<gen5.Result> value) {
    $values[4] = value;
  }

  gen0.ValueLeaf<gen5.Result> get result => $values[4];

  @override
  gen7.TicTacToeDatabase call({Object? serial = #sentinel, Object? turn = #sentinel, Object? contents = #sentinel, Object? owners = #sentinel, Object? result = #sentinel}) {
    if (serial != #sentinel) {
      this.serial = serial as gen0.ValueLeaf<gen1.int>;
    }
    if (turn != #sentinel) {
      this.turn = turn as gen0.ValueLeaf<gen1.int>;
    }
    if (contents != #sentinel) {
      this.contents = contents as gen2.MapLeaf<gen3.Position, gen4.Piece>;
    }
    if (owners != #sentinel) {
      this.owners = owners as gen2.MapLeaf<gen4.Piece, gen4.Player>;
    }
    if (result != #sentinel) {
      this.result = result as gen0.ValueLeaf<gen5.Result>;
    }
    return build();
  }

  gen7.TicTacToeDatabase build() {
    var instance = TicTacToeDatabaseConverter._activator($values);

    return instance;
  }
}

extension TicTacToeDatabaseDogsExtension on gen7.TicTacToeDatabase {
  gen7.TicTacToeDatabase rebuild(Function(TicTacToeDatabaseBuilder b) f) {
    var builder = TicTacToeDatabaseBuilder(this);
    f(builder);
    return builder.build();
  }

  TicTacToeDatabase$Copy get copy => toBuilder();

  TicTacToeDatabaseBuilder toBuilder() {
    return TicTacToeDatabaseBuilder(this);
  }

  Map<String, dynamic> toNative() {
    return gen.dogs.convertObjectToNative(this, gen7.TicTacToeDatabase);
  }
}
