// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unused_field, unused_import, unnecessary_import, public_member_api_docs, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

import 'package:example_tictactoe/database.conv.g.dart';
import 'package:example_tictactoe/entity.conv.g.dart';
import 'package:example_tictactoe/position.conv.g.dart';
import 'package:example_tictactoe/result.conv.g.dart';
import 'package:dogs_core/dogs_core.dart';
import 'package:example_tictactoe/database.conv.g.dart' as gen0;
import 'package:example_tictactoe/entity.conv.g.dart' as gen1;
import 'package:example_tictactoe/position.conv.g.dart' as gen2;
import 'package:example_tictactoe/result.conv.g.dart' as gen3;
export 'package:example_tictactoe/database.conv.g.dart';
export 'package:example_tictactoe/entity.conv.g.dart';
export 'package:example_tictactoe/position.conv.g.dart';
export 'package:example_tictactoe/result.conv.g.dart';

DogPlugin GeneratedModelsPlugin() => (engine) {
  engine.linkAll([
    gen0.TicTacToeDatabaseConverter(),
    gen1.PlayerConverter(),
    gen1.PieceConverter(),
    gen2.PositionConverter(),
    gen3.WinConverter(),
    gen3.DrawConverter(),
  ]);
};
