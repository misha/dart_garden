import 'package:meta/meta.dart';

import 'package:tictactoe/state.dart';
import 'package:tictactoe/objects/entity.dart';
import 'package:tictactoe/objects/position.dart';
import 'package:tictactoe/objects/result.dart';
import 'package:tictactoe/objects/token.dart';

class Game {
  static const players = <Player>[.new(Token.x), .new(Token.o)];
  static const lines = <List<Position>>[
    [.new(0, 0), .new(0, 1), .new(0, 2)],
    [.new(1, 0), .new(1, 1), .new(1, 2)],
    [.new(2, 0), .new(2, 1), .new(2, 2)],
    [.new(0, 0), .new(1, 0), .new(2, 0)],
    [.new(0, 1), .new(1, 1), .new(2, 1)],
    [.new(0, 2), .new(1, 2), .new(2, 2)],
    [.new(0, 0), .new(1, 1), .new(2, 2)],
    [.new(0, 2), .new(1, 1), .new(2, 0)],
  ];

  factory Game.initial() => .load(.initial());
  Game.load(this.s);
  GameData save() => s.save();

  @visibleForTesting
  final GameState s;

  int get turn => s.turn.value;
  Player get currentPlayer => players[turn % 2];
  Player get nextPlayer => players[(turn + 1) % 2];
  Result? get result => s.result.value;
  bool get isRunning => result == null;
  bool get isOver => result != null;

  Piece? getContents(Position position) => s.contents[position];
  Player getOwner(Piece piece) => s.owners[piece]!;

  T simulate<T>(T Function() task) {
    s.garden.branch();

    try {
      return task();
    } finally {
      s.garden.rollback();
    }
  }

  void place(Player player, Position position) {
    if (isOver) throw StateError('Game is over.');
    if (currentPlayer != player) throw StateError('Not your turn.');
    if (position.x != position.x.clamp(0, 2)) throw StateError('Invalid position `x`.');
    if (position.y != position.y.clamp(0, 2)) throw StateError('Invalid position `y`.');
    if (s.contents.containsKey(position)) throw StateError('Position is filled.');
    final piece = Piece(s.serial.value++);
    s.contents[position] = piece;
    s.owners[piece] = player;
    _process();
  }

  void _process() {
    assert(isRunning);

    for (final line in lines) {
      final pieces = line.map(getContents).nonNulls.toList();
      if (pieces.length != 3) continue;
      final owners = pieces.map(getOwner).toSet();
      if (owners.length != 1) continue;
      s.result.value = .win(currentPlayer);
      return;
    }

    if (s.contents.length == 9) {
      s.result.value = .draw();
      return;
    }

    s.turn.value += 1;
  }
}
