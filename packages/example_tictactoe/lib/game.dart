import 'package:dogs_core/dogs_core.dart';
import 'package:garden/garden.dart';
import 'package:example_tictactoe/database.dart';
import 'package:example_tictactoe/entity.dart';
import 'package:example_tictactoe/position.dart';
import 'package:example_tictactoe/result.dart';

class TicTacToe {
  static final players = <Player>[.x, .o];
  static final lines = <List<Position>>[
    [.new(0, 0), .new(0, 1), .new(0, 2)],
    [.new(1, 0), .new(1, 1), .new(1, 2)],
    [.new(2, 0), .new(2, 1), .new(2, 2)],
    [.new(0, 0), .new(1, 0), .new(2, 0)],
    [.new(0, 1), .new(1, 1), .new(2, 1)],
    [.new(0, 2), .new(1, 2), .new(2, 2)],
    [.new(0, 0), .new(1, 1), .new(2, 2)],
    [.new(0, 2), .new(1, 1), .new(2, 0)],
  ];

  factory TicTacToe.initial() {
    final garden = Garden();
    final db = garden.grow(TicTacToeDatabase.initial);
    return .new(garden, db);
  }

  TicTacToe(Garden garden, TicTacToeDatabase db) //
    : _garden = garden,
      _db = db;

  final Garden _garden;
  final TicTacToeDatabase _db;

  int get turn => _db.turn.value;
  Player get currentPlayer => players[turn % 2];
  Player get nextPlayer => players[(turn + 1) % 2];
  Result? get result => _db.result.value;
  bool get isRunning => result == null;
  bool get isOver => result != null;

  Piece? contents(Position position) => _db.contents[position];
  Player owner(Piece piece) => _db.owners[piece]!;

  T simulate<T>(T Function() task) {
    _garden.branch();

    try {
      return task();
    } finally {
      _garden.revert();
    }
  }

  void place(Player player, Position position) {
    if (isOver) throw StateError('Game is over.');
    if (currentPlayer != player) throw StateError('Not your turn.');
    if (position.x != position.x.clamp(0, 2)) throw StateError('Invalid position `x`.');
    if (position.y != position.y.clamp(0, 2)) throw StateError('Invalid position `y`.');
    if (_db.contents.containsKey(position)) throw StateError('Position is filled.');
    final piece = Piece(_db.serial.value++);
    _db.contents[position] = piece;
    _db.owners[piece] = player;
    _process();
  }

  void _process() {
    assert(isRunning);

    for (final line in lines) {
      final pieces = line.map(contents).nonNulls.toList();
      if (pieces.length != 3) continue;
      final owners = pieces.map(owner).toSet();
      if (owners.length != 1) continue;
      _db.result.value = Win(currentPlayer);
      return;
    }

    if (_db.contents.length == 9) {
      _db.result.value = Draw();
      return;
    }

    _db.turn.value += 1;
  }

  //
  // Serialization
  //

  Map<String, dynamic> dump() => dogs.toNative(_db, type: TicTacToeDatabase);

  factory TicTacToe.load(Map<String, dynamic> data) {
    final garden = Garden();
    final db = garden.grow(() => dogs.fromNative<TicTacToeDatabase>(data));
    return .new(garden, db);
  }
}
