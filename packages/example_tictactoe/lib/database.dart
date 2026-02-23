import 'package:dogs_core/dogs_core.dart';
import 'package:garden/garden.dart';
import 'package:example_tictactoe/entity.dart';
import 'package:example_tictactoe/position.dart';
import 'package:example_tictactoe/result.dart';

@serializable
class TicTacToeDatabase with Dataclass<TicTacToeDatabase> {
  factory TicTacToeDatabase.initial() {
    return .new(
      serial: ValueLeaf(0),
      turn: ValueLeaf(0),
      contents: MapLeaf(),
      owners: MapLeaf(),
      result: ValueLeaf(null),
    );
  }

  TicTacToeDatabase({
    required this.serial,
    required this.turn,
    required this.contents,
    required this.owners,
    required this.result,
  });

  final ValueLeaf<int> serial;
  final ValueLeaf<int> turn;
  final MapLeaf<Position, Piece> contents;
  final MapLeaf<Piece, Player> owners;
  @polymorphic
  final ValueLeaf<Result?> result;
}
