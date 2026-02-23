// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unused_field, unused_import, unnecessary_import, public_member_api_docs, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

import 'dart:core';
import 'package:dogs_core/dogs_core.dart' as gen;
import 'package:lyell/lyell.dart' as gen;
import 'package:example_tictactoe/entity.dart' as gen0;
import 'package:example_tictactoe/result.dart' as gen1;
import 'package:dogs_core/src/annotations.dart' as gen2;
import 'package:example_tictactoe/result.dart';

class WinConverter extends gen.DefaultStructureConverter<gen1.Win> {
  WinConverter()
    : super(
        struct: const gen.DogStructure<gen1.Win>(
          'Win',
          gen.StructureConformity.dataclass,
          [gen.DogStructureField(gen.QualifiedTerminal<gen0.Player>(), null, 'winner', false, true, [])],
          [gen2.serializable],
          gen.ObjectFactoryStructureProxy<gen1.Win>(_activator, [_$winner], _values, _hash, _equals),
        ),
      );

  static dynamic _$winner(gen1.Win obj) => obj.winner;

  static List<dynamic> _values(gen1.Win obj) => [obj.winner];

  static gen1.Win _activator(List list) {
    return gen1.Win(list[0]);
  }

  static int _hash(gen1.Win obj) => obj.winner.hashCode;

  static bool _equals(gen1.Win a, gen1.Win b) => (a.winner == b.winner);
}

abstract class Win$Copy {
  gen1.Win call({gen0.Player? winner});
}

class WinBuilder implements Win$Copy {
  WinBuilder([gen1.Win? $src]) {
    if ($src == null) {
      $values = List.filled(1, null);
    } else {
      $values = WinConverter._values($src);
      this.$src = $src;
    }
  }

  late List<dynamic> $values;

  gen1.Win? $src;

  set winner(gen0.Player value) {
    $values[0] = value;
  }

  gen0.Player get winner => $values[0];

  @override
  gen1.Win call({Object? winner = #sentinel}) {
    if (winner != #sentinel) {
      this.winner = winner as gen0.Player;
    }
    return build();
  }

  gen1.Win build() {
    var instance = WinConverter._activator($values);

    return instance;
  }
}

extension WinDogsExtension on gen1.Win {
  gen1.Win rebuild(Function(WinBuilder b) f) {
    var builder = WinBuilder(this);
    f(builder);
    return builder.build();
  }

  Win$Copy get copy => toBuilder();

  WinBuilder toBuilder() {
    return WinBuilder(this);
  }

  Map<String, dynamic> toNative() {
    return gen.dogs.convertObjectToNative(this, gen1.Win);
  }
}

class DrawFactory {
  static gen1.Draw create() {
    var obj = gen1.Draw();
    return obj;
  }
}

class DrawConverter extends gen.DefaultStructureConverter<gen1.Draw> {
  DrawConverter()
    : super(struct: const gen.DogStructure<gen1.Draw>('Draw', gen.StructureConformity.bean, [], [gen2.serializable], gen.ObjectFactoryStructureProxy<gen1.Draw>(_activator, [], _values)));

  static List<dynamic> _values(gen1.Draw obj) => [];

  static gen1.Draw _activator(List list) {
    var obj = gen1.Draw();
    return obj;
  }
}
