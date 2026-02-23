import 'package:dogs_core/dogs_core.dart';

sealed class Entity {
  // No fields.
}

@serializable
class Player extends Entity with Dataclass<Player> {
  static final x = Player('x');
  static final o = Player('o');

  Player(this.symbol);

  final String symbol;
}

@serializable
class Piece extends Entity with Dataclass<Piece> {
  Piece(this.id);

  final int id;
}
