import 'package:dogs_core/dogs_core.dart';
import 'package:example_tictactoe/entity.dart';

sealed class Result {
  // No fields.
}

@serializable
class Win extends Result with Dataclass<Win> {
  Win(this.winner);

  final Player winner;
}

@serializable
class Draw extends Result with Dataclass<Draw> {
  // No fields.
}
