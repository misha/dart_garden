import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garden/garden.dart';

import 'package:tictactoe/objects/entity.dart';
import 'package:tictactoe/objects/position.dart';
import 'package:tictactoe/objects/result.dart';

part 'state.freezed.dart';
part 'state.g.dart';

/// Serializable version of the game state.
@freezed
abstract class GameData with _$GameData {
  const factory GameData({
    required int serial,
    required int turn,
    required Iterable<(Position, Piece)> contents,
    required Iterable<(Piece, Player)> owners,
    required Result? result,
  }) = _GameData;

  factory GameData.fromJson(Map<String, Object?> json) => _$GameDataFromJson(json);
}

/// Runtime version of the game state.
class GameState {
  factory GameState.initial() {
    return .new(
      .new(
        serial: 1,
        turn: 0,
        contents: const [],
        owners: const [],
        result: null,
      ),
    );
  }

  factory GameState(GameData data) {
    return ._(Garden(), data);
  }

  GameState._(Garden garden, GameData data)
    : garden = garden,
      serial = garden.grow(.new(data.serial)),
      turn = garden.grow(.new(data.turn)),
      contents = garden.grow(.pairs(data.contents)),
      owners = garden.grow(.pairs(data.owners)),
      result = garden.grow(.new(data.result));

  GameData save() {
    return .new(
      serial: serial.value,
      turn: turn.value,
      contents: contents.pairs,
      owners: owners.pairs,
      result: result.value,
    );
  }

  final Garden garden;
  final ValueLeaf<int> serial;
  final ValueLeaf<int> turn;
  final MapLeaf<Position, Piece> contents;
  final MapLeaf<Piece, Player> owners;
  final ValueLeaf<Result?> result;
}
